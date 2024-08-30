import { NotionAPI } from "notion-client";
import { OptionsOfJSONResponseBody } from "got";
import { CollectionInstance, CollectionViewType, ExtendedRecordMap } from "notion-types";
import {
  uuidToId,
  getPageContentBlockIds,
  getBlockCollectionId,
} from "notion-utils";
import pMap from "p-map";

export class CustomNotionAPI extends NotionAPI {
  private readonly _customUserTimeZone: string

  constructor({
    apiBaseUrl = 'https://www.notion.so/api/v3',
    authToken,
    activeUser,
    userTimeZone = 'America/New_York'
  }: {
    apiBaseUrl?: string
    authToken?: string
    userLocale?: string
    userTimeZone?: string
    activeUser?: string
  } = {}) {
    super({ apiBaseUrl, authToken, userTimeZone, activeUser })
    this._customUserTimeZone = userTimeZone
  }

  public async getCollectionDataWithFilter(
    collectionId: string,
    collectionViewId: string,
    collectionView: any,
    {
      limit = 9999,
      searchQuery = '',
      userTimeZone = this._customUserTimeZone,
      loadContentCover = true,
      customFilters = null,  // 커스텀 필터를 추가
      gotOptions
    }: {
      type?: CollectionViewType
      limit?: number
      searchQuery?: string
      userTimeZone?: string
      userLocale?: string
      loadContentCover?: boolean
      customFilters?: any[] | null  // 커스텀 필터를 추가
      gotOptions?: OptionsOfJSONResponseBody
    } = {}
  ) {
    const type = collectionView?.type;
    const isBoardType = type === 'board';
    const groupBy = isBoardType
      ? collectionView?.format?.board_columns_by
      : collectionView?.format?.collection_group_by;
  
    let filters = [];
  
    // 커스텀 필터가 제공되었다면, 이를 사용하여 기존 필터를 오버라이드
    if (customFilters && customFilters.length > 0) {
      filters = customFilters;
    } else {
      // 기존 필터 적용
      if (collectionView?.format?.property_filters) {
        filters = collectionView.format?.property_filters.map((filterObj: any) => {
          return {
            filter: filterObj?.filter?.filter,
            property: filterObj?.filter?.property,
          };
        });
      }
  
      // query2 필터 추가
      if (collectionView?.query2?.filter?.filters) {
        filters.push(...collectionView.query2.filter.filters);
      }
    }
  
    let loader: any = {
      type: 'reducer',
      reducers: {
        collection_group_results: {
          type: 'results',
          limit,
          loadContentCover,
        },
      },
      sort: [],
      ...collectionView?.query2,
      filter: {
        filters: filters,  // 적용된 필터 사용
        operator: 'and',
      },
      searchQuery,
      userTimeZone,
    };
  
    if (groupBy) {
      const groups =
        collectionView?.format?.board_columns ||
        collectionView?.format?.collection_groups ||
        [];
      const iterators = [isBoardType ? 'board' : 'group_aggregation', 'results'];
      const operators = {
        checkbox: 'checkbox_is',
        url: 'string_starts_with',
        text: 'string_starts_with',
        select: 'enum_is',
        multi_select: 'enum_contains',
        created_time: 'date_is_within',
        ['undefined']: 'is_empty',
      };
  
      const reducersQuery = {};
      for (const group of groups) {
        const {
          property,
          value: { value, type },
        } = group;
  
        for (const iterator of iterators) {
          const iteratorProps =
            iterator === 'results'
              ? {
                  type: iterator,
                  limit,
                }
              : {
                  type: 'aggregation',
                  aggregation: {
                    aggregator: 'count',
                  },
                };
  
          const isUncategorizedValue = typeof value === 'undefined';
          const isDateValue = value?.range;
          const queryLabel = isUncategorizedValue
            ? 'uncategorized'
            : isDateValue
            ? value.range?.start_date || value.range?.end_date
            : value?.value || value;
  
          const queryValue =
            !isUncategorizedValue && (isDateValue || value?.value || value);
  
          // @ts-ignore
          reducersQuery[`${iterator}:${type}:${queryLabel}`] = {
            ...iteratorProps,
            filter: {
              operator: 'and',
              filters: [
                {
                  property,
                  filter: {
                    operator: !isUncategorizedValue ? operators[type as keyof typeof operators] : 'is_empty',
                    ...(!isUncategorizedValue && {
                      value: {
                        type: 'exact',
                        value: queryValue,
                      },
                    }),
                  },
                },
              ],
            },
          };
        }
      }
  
      const reducerLabel = isBoardType ? 'board_columns' : `${type}_groups`;
      loader = {
        type: 'reducer',
        reducers: {
          [reducerLabel]: {
            type: 'groups',
            groupBy,
            ...(collectionView?.query2?.filter && {
              filter: collectionView?.query2?.filter,
            }),
            groupSortPreference: groups.map((group: any) => group?.value),
            limit,
          },
          ...reducersQuery,
        },
        ...collectionView?.query2,
        searchQuery,
        userTimeZone,
        filter: {
          filters: filters,  // 최종 필터 사용
          operator: 'and',
        },
      };
    }
  
    return this.fetch<CollectionInstance>({
      endpoint: 'queryCollection',
      body: {
        collection: {
          id: collectionId,
        },
        collectionView: {
          id: collectionViewId,
        },
        loader,
      },
      gotOptions,
    });
  }

  public async getPageWithCollection(
    pageId: string,
    {
      concurrency = 3,
      fetchMissingBlocks = true,
      fetchCollections = true,
      signFileUrls = true,
      chunkLimit = 100,
      chunkNumber = 0,
      customFilters,  // 추가된 필터 파라미터
      gotOptions
    }: {
      concurrency?: number
      fetchMissingBlocks?: boolean
      fetchCollections?: boolean
      signFileUrls?: boolean
      chunkLimit?: number
      chunkNumber?: number
      customFilters?: any[] | null
      gotOptions?: OptionsOfJSONResponseBody
    } = {}
  ): Promise<ExtendedRecordMap> {
    // 1. 페이지 데이터 가져오기
    const page = await this.getPageRaw(pageId, {
      chunkLimit,
      chunkNumber,
      gotOptions
    });
    const recordMap = page?.recordMap as ExtendedRecordMap;
  
    if (!recordMap?.block) {
      throw new Error(`Notion page not found "${uuidToId(pageId)}"`);
    }
  
    // ensure that all top-level maps exist
    recordMap.collection = recordMap.collection ?? {};
    recordMap.collection_view = recordMap.collection_view ?? {};
    recordMap.notion_user = recordMap.notion_user ?? {};
  
    // additional mappings added for convenience
    recordMap.collection_query = {};
    recordMap.signed_urls = {};
  
    // 2. collection_view_page 블록 확인
    const contentBlockIds = getPageContentBlockIds(recordMap);
    const collectionViewPageBlock = contentBlockIds
      .map((blockId) => recordMap.block[blockId].value)
      .find((block) => block.type === 'collection_view');
  
    if (!collectionViewPageBlock) {
      throw new Error("Page is not a Database");
    }
  
    const collectionId = getBlockCollectionId(collectionViewPageBlock, recordMap);
    const collectionViewId = collectionViewPageBlock.view_ids?.[0];
  
    if (!collectionId || !collectionViewId) {
      throw new Error("Collection or Collection View not found");
    }
  
    // 3. 컬렉션 데이터 가져오기
    if (fetchCollections) {
      await pMap(
        [{ collectionId, collectionViewId }],
        async ({ collectionId, collectionViewId }) => {
          const collectionView = recordMap.collection_view[collectionViewId]?.value;
  
          try {
            const collectionData = await this.getCollectionDataWithFilter(
              collectionId,
              collectionViewId,
              collectionView,
              {
                gotOptions,
                customFilters: customFilters,
              }
            );
  
            recordMap.block = {
              ...recordMap.block,
              ...collectionData.recordMap.block
            };
  
            recordMap.collection = {
              ...recordMap.collection,
              ...collectionData.recordMap.collection
            };
  
            recordMap.collection_view = {
              ...recordMap.collection_view,
              ...collectionData.recordMap.collection_view
            };
  
            recordMap.notion_user = {
              ...recordMap.notion_user,
              ...collectionData.recordMap.notion_user
            };
  
            recordMap.collection_query![collectionId] = {
              ...recordMap.collection_query![collectionId],
              [collectionViewId]: (collectionData.result as any)?.reducerResults
            };
          } catch (err) {
            console.warn('NotionAPI collectionQuery error', pageId, err);
            console.error(err);
          }
        },
        { concurrency }
      );
    }
  
    // 4. 누락된 블록 데이터를 가져오기 (필요한 경우)
    if (fetchMissingBlocks) {
      while (true) {
        const pendingBlockIds = getPageContentBlockIds(recordMap).filter(
          (id) => !recordMap.block[id]
        );
  
        if (!pendingBlockIds.length) {
          break;
        }
  
        const newBlocks = await this.getBlocks(pendingBlockIds, gotOptions).then((res) => res.recordMap.block);
        recordMap.block = { ...recordMap.block, ...newBlocks };
      }
    }
  
    // 5. 서명된 URL을 가져오기 (필요한 경우)
    if (signFileUrls) {
      await this.addSignedUrls({ recordMap, contentBlockIds, gotOptions });
    }
  
    // 6. 최종 recordMap 반환
    return recordMap;
  }
}