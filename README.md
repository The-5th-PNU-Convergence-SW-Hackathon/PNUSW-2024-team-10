# Heron: Aid for PNU Students

![heron_og](https://github.com/user-attachments/assets/2ca99d76-6f58-4fda-a7c3-065b519efeb1)

## 1. 프로젝트 소개
1. 프로젝트 명
   - 히론(Heron): 철새였지만 한국의 자연환경에 적응하여 정착한 왜가리(Heron)에서 이름을 착안. 부산대학교를 선택한 외국인 유학생들이 왜가리처럼 부산에 잘 적응하고, 오랜 기간 생활을 이어나가길 바라는 의미를 담았음
2. 개발목표 및 주요 내용
   - 개발목표
      - 부산대학교 외국인 유학생의 문화적응도 및 유학 만족도 향상
         - 서비스의 핵심 사용자는 부산대학교에 재학 중인 외국인 유학생이다. 부산 관광의 정보 접근성과 편의성을 향상시킬 수 있는 기능과 콘텐츠를 제공하여 외국인 유학생의 부산 관광을 촉진하고, 문화 적응을 돕는다. 이와 동시에 유학 생활에 필수적인 정보를 제공하는 콘텐츠를 발행하여 유학 생활의 편의를 증진한다.
      - 주요 개발 목표
         - 관광을 통한 부산대학교 외국인 유학생의 문화적응도 향상
         - 부산대학교 외국인 유학생에게 유학 생활의 편의 제공
   - 주요 내용
      - 지도
         - 부산의 주요 관광지 및 맛집 정보를 지도의 형태로 제공하여 관광 정보에 대한 외국인 유학생의 접근성 향상
      - 여행 코스
         - 부산 여행 코스를 제작 및 게시하여 외국인 유학생의 편리한 부산 관광에 기여
      - 유학생 정보 제공
         - 외국인 유학생이 유학 생활을 하면서 필요로 하는 정보들을 아티클의 형식으로 제공하여 유학 생활 만족도 향상
      - 여행 메이트 매칭
         - 히론에 있는 여행 코스를 함께 여행할 수 있는 외국인 유학생 친구를 모집할 수 있도록 하여 외국인 유학생 간 커뮤니케이션 촉진
3. 세부 내용
   - 세부 내용
      - 지도
         - 관광지 정보
         - 데이터 소스: 부산관광공사, 비짓부산 등의 자료를 참고하여 데이터 수집
         - 관광지 카테고리: 원도심, 해운대/광안리, 기장 세 권역으로 구분
         - 관광지 테마: 역사, 자연, 문화, 쇼핑 등의 테마별 관광지 분류
         - 위치 선택 시 해당 장소의 상세 정보를 확인할 수 있음
         - 맛집 정보
         - 데이터 소스: 미쉐린 가이드, 블루리본 서베이 등의 자료를 참고하여 데이터 수집
         - 필터: 혼밥, 할랄, 비건 등 유학생들이 식당을 찾을 때 필요로 할 정보들을 바탕으로 필터 제공
         - 위치 선택 시 해당 장소의 상세 정보를 확인할 수 있음
      - 여행 코스
         - 여행 코스 추천
         - 여행 코스: 거리, 시간, 환경, 테마 등의 조건에 따른 여행 코스 제공.
         - 여행 코스 종류: 1박2일 코스와 당일 여행 코스 제공
         - 여행 코스 필터: 권역 필터 (원도심, 해운대/광안리, 기장), 테마 필터 (역사, 자연, 문화, 쇼핑)
         - 검색: 코스 전체, 위시리스트, 완료 필터를 통한 코스 검색 가능
         - 미션
         - 코스 내에 여행을 하면서 수행할 수 있는 미션 제공. 미션 해결을 통해 유학생은 여행 코스에 대한 흥미를 느끼고, 몰입하게 됨
         - 코스 여행 시작 시 미션 수행 인증이 활성화. 인증 사진을 등록하면 미션 인증이 됨.
      - 유학생 정보 제공
         - 유학 필수 정보
         - 외국인 등록증 발급, 국민건강보험 등 한국 유학에 필수적인 정보를 제공
         - 유학생들의 편의를 위해 모든 콘텐츠를 영어로 작성
         - 국제처 공지
         - 부산대학교 국제처 브로셔와 연계하여 학교 생활에 필요한 다양한 정보 제공
         - 국제처에서 업로드하는 공지사항을 ‘히론’ 앱에도 업로드
      - 여행 메이트 매칭 (추후 서비스 내 기능 구현 예정)
         - 여행 메이트 모집
         - 히론에 등록된 여행 코스를 함께 여행할 유학생 친구를 모집할 수 있음
         - 현재 구현 방식
         - 여행 메이트 모집이 이루어지는 카카오톡 오픈채팅방 링크가 있는 게시글을 사용자들에게 노출
         - 1:1 채팅방을 통해 재학생 인증 후 오픈채팅방 초대
         - 오픈채팅방에서 자유롭게 여행메이트를 모집할 수 있음
         - 추후 서비스 확장 시 히론 애플리케이션 내에 여행 메이트를 모집할 수 있는 커뮤니티 기능 개발 예정
4. 차별성
   1. 네이버지도
      - 주요 기능: 위치 기반의 지도 서비스로, 다양한 장소의 정보(식당, 카페, 관광지 등)를 제공
      - 차별성
         - 히론: 외국인 유학생을 위한 맞춤형 정보 제공. 예를 들어, 유학생들이 필요로 하는 정보(비건, 할랄 식당 등)를 필터링할 수 있는 기능이 있음
         - 네이버지도: 일반 사용자 대상이며, 특정 사용자층(외국인 유학생)에 대한 맞춤형 정보는 부족
   2. 트리플
      - 주요 기능: 트리플은 여행 계획 및 코스 추천 서비스로, 사용자 맞춤형 여행 코스를 제공
      - 차별성
         - 히론: 부산대학교 외국인 유학생의 문화적응을 지원하는 콘텐츠와 기능을 포함 (ex. 유학 필수 정보와 국제처 공지사항을 제공하여 유학생의 생활 편의를 도모)
         - 트리플: 일반적인 여행 계획에 중점을 두며, 유학 생활에 필요한 정보는 제공하지 않음
   3. 마이리얼트립
      - 주요 기능: 마이리얼트립은 여행 상품 예약 및 현지 가이드 서비스를 제공하는 플랫폼
      - 차별성
         - 히론: 여행 메이트 매칭 기능, 이는 유학생들이 함께 여행할 친구, 나아가 유학 생활을 함께할 친구를 찾을 수 있도록 도움
         - 마이리얼트립: 주로 여행 상품 예약에 중점을 두고 있으며, 사용자 간의 소통 기능은 제한적
   4. Life in Busan
      - 주요 기능: 부산의 생활 정보와 관광 정보를 제공하는 플랫폼
      - 차별성
         - 히론: 유학 생활에 필요한 정보와 관광 정보를 통합하여 제공, 미션 기반의 여행 코스를 통해 흥미를 유도
         - Life in Busan: 일반적인 외국인 행정 정보 제공에 중점을 두며, 특정 사용자층에 대한 맞춤형 서비스는 부족
      - 활용방안
         - 수익모델
            - 부산 내에 위치한 주요 관광지 및 식당과 제휴 협약
            - 히론: 제휴 협약을 통한 안정적인 수익 창출 모델 확보
            - 제휴 업체: 제휴 협약을 통한 홍보 효과 창출
            - 지역 사회: 외국인 유학생의 부산 관광 증대를 통한 지역 경제 활성화
         - 기대효과
            - 관광 정보 접근성 향상: 외국인 유학생을 대상으로 한 부산 관광 정보 제공
            - 문화적응도 향상: 부산 관광을 통한 외국인 유학생의 한국 문화적응도 향상
            - 커뮤니케이션 증진: 교내 외국인 유학생 간 커뮤니케이션을 할 수 있는 환경을 마련하여 유학생 간 커뮤니케이션 증진
            - 유학 만족도 향상: 위의 기대효과를 충족하여 궁극적으로 외국인 유학생의 유학 만족도 향상에 기여
         - 사회적 가치
            - 부산 지역 내 외국인 유학생 유치 ↑
            - 부산대학교 외국인 유학생을 대상으로 서비스를 시작하여 추후 부산권 외국인 유학생을 대상으로 서비스 확장
            - 부산 지역 내 외국인 유학생의 한국 문화적응도 향상 → 외국인 유학생의 유학 만족도 향상 및 외국인 유학생 유치 ↑
            - 부산 지역 인바운드 관광 활성화
            - 부산 지역을 관광하는 외국인 유학생의 증가는 곧 부산 지역 인바운드 관광의 활성화를 의미

## 2. 상세설계
1. 시스템구성도

   ![heron_%EC%8B%9C%EC%8A%A4%ED%85%9C_%EA%B5%AC%EC%84%B1%EB%8F%84 drawio](https://github.com/user-attachments/assets/79538cb4-f781-45dc-af02-5b62c0242de7)

2. 사용기술

   1. Backend

      - SpringBoot 3.3.1
      - AWS RDS
      - AWS EC2
      - AWS CodeDeply
      - AWS S3
      - Github Action

   2. Frontend
      - Flutter
      - NextJS (정보 페이지, 웹뷰)

## 3. 개발결과

1. 전체 시스템 흐름도

   1. IA(Information Architecture)

      전체적인 시스템 구조의 정보를 간단히 도식화하여 보여줍니다.

      ![IA](https://github.com/user-attachments/assets/7a99727e-7fe5-4d5f-8c70-0d7aabb0697a)

   2. ERD(Entity Relationship Diagram**)**
      데이터베이스 내의 요소가 어떻게 관련되어 있는지 보여줍니다.

      ![HERON-ERD](https://github.com/user-attachments/assets/e06b7154-187e-42cd-9e0e-354973ac8b7c)

   3. Flow Chart

      1. 시작화면-지도

         ![지도장소불러오기](https://github.com/user-attachments/assets/b49ada2b-127e-486d-b021-8bf111e33c7b)

      2. 지도-위시 리스트 등록
         ![장소위시리스트](https://github.com/user-attachments/assets/415c5425-1cff-4a04-8ea4-83ae6064b2ff)
      3. 코스 시작

         ![코스시작](https://github.com/user-attachments/assets/d340171b-626f-4bb2-9e91-97122f0c337e)

      4. 완료 코스 조회 및 희망 코스 시작하기

         ![미션_등록](https://github.com/user-attachments/assets/15103f52-d53e-4ff1-93cb-44a11a19164c)

      5. 여행 메이트 모집 및 유학생 정보 게시판

         ![플로우차트_정보게시판](https://github.com/user-attachments/assets/627eca67-4fbe-4438-a81a-e709278c2169)

      6. 설정

         ![플로우차트_설정](https://github.com/user-attachments/assets/45f917a2-a3ef-4297-b487-f03b0c6f738a)

2. 기능설명

   1. 지도

      ![지도](https://github.com/user-attachments/assets/df1fc2da-422e-4c39-a01f-9632565d6958)

      1. 앱 시작 시 처음으로 구동되는 화면입니다.
      2. 화면을 확대해서 서비스에 등록된 모든 장소를 찾을 수 있습니다. Reset Camera 버튼을 누르면 처음으로 돌아갑니다.
      3. 장소를 터치하면 장소의 세부 정보를 확인할 수 있습니다.
      4. 상단의 빠른 필터, 하단의 좋아요 버튼으로 필터를 적용시킬 수 있고, 좌상단의 필터 버튼을 눌러 상세 설정도 가능합니다.

   2. 장소

      ![장소](https://github.com/user-attachments/assets/23af7bb1-66de-4b64-8352-1b83d10f894f)

      1. 앱 내 어떤 화면에서든장소를 터치하면 장소의 세부 정보를 팝업 형태로 출력합니다.
      2. 로그인이 된 상태이면 좋아요 버튼을 눌러 해당 장소에 좋아요를 설정하여 지도의 필터 기능으로 분리해서 출력할 수 있습니다.
      3. more 버튼 혹은 제목을 클릭하면 Google Map 어플리케이션을 열어 더 자세한 장소 정보를 확인할 수 있습니다.
      4. 도로명 주소를 클릭하면 주소가 클립보드에 자동으로 복사됩니다.
      5. Google의 Place API와 연동하여 자동으로 장소 사진을 표시합니다.

   3. 코스 (메인)

      ![코스 메인](https://github.com/user-attachments/assets/c3e8ccd2-de66-46f8-8dd2-32c6e9449dc7)

      1. 앱에 등록된 모든 코스를 확인할 수 있습니다. 코스의 내용을 쉽게 알아볼 수 있도록 태그 시스템을 적용하였습니다.
      2. 상단의 탭을 전환해서 좋아요 표시한 코스, 완료한 코스만 따로 확인할 수 있습니다.
      3. 상단의 필터 버튼을 눌러 코스에 대한 상세 필터를 적용할 수 있습니다.

   4. 코스 (세부정보)

      ![코스 정보](https://github.com/user-attachments/assets/2e54a226-324e-47af-875e-b06c633a8471)

      1. 코스의 기본 정보와 코스 내에 등록된 모든 장소, 추천 시간, 미션을 확인할 수 있습니다.
      2. 장소를 터치하면 장소의 세부 정보를 확인할 수 있습니다.
      3. 로그인이 된 상태일 시 여행 코스를 즉시 시작할 수 있으며, 좋아요 기능을 사용할 수 있습니다.

   5. 코스 (진행 중)

      ![코스 진행](https://github.com/user-attachments/assets/0e83caf8-310f-45af-b0f3-2113a10ed082)

      1. 코스를 시작하면 나열된 순서대로 해당 장소에서 찍은 ‘인증샷’을 업로드해야 합니다.
         1. 인증샷은 갤러리에서 선택하거나 카메라로 바로 촬영할 수 있습니다.
      2. 인증샷을 업로드하면 코스의 진행도가 상승하며, 모든 인증샷이 업로드되면 코스는 완료됩니다.
      3. 코스가 완료되지 않은 상태에서 중단할 수 있으며, 이 경우 코스는 완료 처리되지만 진행도는 100%가 되지 않습니다.

   6. 정보

      ![정보](https://github.com/user-attachments/assets/e9b8b075-ccba-45e6-8da1-e610abba5514)

      1. 부산대 국제처 공지사항, 유학 가이드, 앱 내 공지사항 등을 리스트 형태로 확인할 수 있습니다.
      2. 상단의 필터 버튼을 클릭하여 원하는 정보만 확인할 수도 있습니다.
      3. 게시물은 웹 페이지 링크의 형태로 공유할 수 있습니다.

   7. 메뉴

      ![더보기 및 로그인](https://github.com/user-attachments/assets/d4d32d43-9ab0-4798-b856-7928d8007e8e)

      1. 사용자 프로필 확인, 앱 환경설정, 약관 등 기타 정보를 확인할 수 있습니다.
      2. 로그인하지 않은 상태일 경우 로그인 팝업을 표시합니다. (로그인이 필요한 모든 기능 공통)

   8. 메뉴 (언어 설정)

      ![한국어화](https://github.com/user-attachments/assets/49b27c17-b545-49e1-ab27-8bbdd7b2b988)

      1. 앱 내 모든 정보는 기본적으로 영어로 표기되지만, 설정을 통해 한국어로 변경할 수 있습니다.
      2. 앱 내 기능, 장소 정보 등은 전부 한국어화가 완료되었으나, 코스 및 정보는 영어로만 사용할 수 있습니다.

3. 기능명세서

   1. 지도

      ![Group 1](https://github.com/user-attachments/assets/24924c02-7446-4c14-80f7-9fb121bc9452)
      
      1. 상세 필터 버튼 - 상세 필터 팝업을 표시합니다.
      2. 빠른 필터 - 관광지 및 식당에 대한 필터를 빠르게 적용합니다.
      3. 시점 원위치 - 처음 위치 (부산광역시 전체가 보임) 위치로 돌아갑니다.
      4. 좋아요 - 좋아요 표시한 장소만 표시
      5. 네비게이션 바 - 원하는 페이지로 이동
      6. 장소 마커 - 터치 시 장소의 세부 정보를 표시
      7. 리셋 - 터치 시 필터 정보를 초기화
      8. 필터 선택 - 원하는 필터를 토글 형식으로 선택
      9. 필터 적용 - 선택한 필터를 적용

   2. 장소

      ![Group 9](https://github.com/user-attachments/assets/8ce84e6f-2110-45f2-bdcb-fe987e60324e)

      10. 장소 이름 - 클릭 시 구글 맵 어플리케이션 실행 후 동일 장소를 표시
      11. 좋아요 - 선택한 장소를 위시리스트에 추가 가능
      12. 주소 및 음식 메뉴 - 장소가 식당일 경우 주소와 음식 메뉴를 동시에 제공
      13. 권역 및 테마 - 장소의 카테고리에 해당하는 정보로, 이를 통해 필터 기능을 제공
      14. 썸네일 - 장소의 대표 사진

   3. 코스 메인

      ![Group 10](https://github.com/user-attachments/assets/ef9887e0-2d66-48df-a614-79062bcd8a63)

      15. 탭 바 - 모든 코스, 위시 리스트에 속해 있는 코스, 완료한 코스 조회 가능
      16. 필터 - 코스를 테마 등 카테고리별로 구분해서 조회 가능
      17. 코스 목록 - 터치 시 코스 상세페이지로 이동
      18. 리셋 - 선택한 필터 초기화
      19. 코스 필터 - 권역 및 코스 테마 선택가능
      20. 필터 적용 - 사용자가 선택한 필터에 따라 코스 목록 재조회
   
   4. 코스 상세

      ![Group 3](https://github.com/user-attachments/assets/a6447f05-f88e-4b18-adc1-5457a30c017e)

      21. 좋아요 - 해당 코스 위시 리스트에 추가
      22. 코스 개요 - 해당 코스의 이름, 랜드마크 세부 정보 및 썸네일
      23. 여행 일정 - 장소, 추천 시간대, 미션 등이 담긴 리스트입니다. 터치 시 해당 장소의 상세정보 팝업 표시
      24. 코스 시작 - 선택한 코스 시작
      25. 코스 시작 확인 팝업 - 실수로 코스가 시작되는 것을 방지

   5. 코스 진행

      ![Group 4](https://github.com/user-attachments/assets/1aed91cb-081b-4b73-a978-80eb2138a5c2)

      26. 사진 업로드 - 진행 중인 코스에 대한 인증샷 촬영 또는 업로드. 해당 작업을 수행해야 미션이 완료됩니다.
      27. 중단 - 진행중인 코스 중단하기
      28. 코스 진척도 - 진행중인 코스에 대한 진척도
      29. 중단 확인 팝업 - 실수로 코스가 중단되는 것을 방지

   6. 정보 게시판

      ![Group 5](https://github.com/user-attachments/assets/6715f2ce-eff0-47ce-8b46-aeeee7312680)

      30. 필터 버튼 - 클릭시 태그 필터 팝업 표시
      31. 게시판 - 현재 애플리케이션에서 보여지는 게시글 목록
      32. 초기화 - 사용자가 선택한 게시판 태그 초기화
      33. 태그 및 적용 - 사용자가 선택한 게시판 태그 적용
      34. 공유 - 선택한 게시글의 링크를 외부로 공유

   7. 메뉴

      ![Group 6](https://github.com/user-attachments/assets/cb682e86-1397-4967-a019-06acd78622d4)

      35. 앱 환경설정 - 클릭 시 팝업을 열어 언어 또는 테마를 변경합니다.
      36. 저작권 및 정책 - 클릭 시 애플리케이션에서 사용되는 파일의 저작권 표시 및 애플리케이션 정책을 표시합니다.
      37. 로그인 - 클릭 시 선택한 소셜 로그인 제공자로 계정을 생성 또는 로그인합니다.
      38. 로그아웃 - 클릭 시 기기에서 계정을 로그아웃합니다.
      39. 계정 삭제 - 클릭 시 회원 탈퇴를 진행합니다.
     
4. 멘토링 의견 반영사항
    1. 산업체 멘토링 의견 반영사항
        1. 프로젝트 소개에 대한 피드백
            
            > 개발 배경 작성과 관련하여, 전달하고자 하는 메시지가 분명해지도록 소목차를 활용하는 것이 내용 전달 효율을 높이는 방법이 될 것으로 생각됨.
            
            1. 리드미에서 제공하는 기본 양식을 최대한 지켜 작성했습니다.
        2. 활용방안에 대한 피드백
            
            > 활용방안 부분은 본 프로젝트 결과물의 효과를 기재한다기 보다는 개발된 앱을 어떠한 방식으로 제공하고, 어떠한 부가서비스, 연계서비스를 제공할 것이며, 홍보/마케팅을 통해 활용성을 어떤 방식으로 높일 것인지에 대한 내용들이 담기는 것이 바람직할 것으로 생각됨 
            
            1. 실제 유저 테스트를 진행하여 애플리케이션 타켓층을 수정할 예정입니다.
            2. 현재 계획중인 연계 서비스는 타 지역 외국인 유학생과 부산의 외국인 유학생 교류를 계획중입니다.
        3. 실현 및 구체화 계획에 대한 피드백
            
            > 예를 들어, 외국인 유학생들이 소통하기에 편리한 UI구현 또는 다국적 언어 지원을 통해 ‘외국인 유학생’을 타겟으로 하는 맞춤형 앱을 개발하고자 하는 목표를 제시하면 더 좋을 것으로 판단됨
            
            1. 현재 지원하는 언어는 한국어,영어 2개 국어이지만 부산대 외국인 유학생 중 많이 사용하는 언어 순으로 추가 될 예정입니다.
    2. 중간 발표 피드백
        
        > 외국인 유학생을 대상으로 하는 관광서비스에서 추가적인 서비스가 필요
        
        1. 현재 유학생 정보 게시판을 통해서 여행 메이트를 모집하고 있습니다. 게시글에 대한 댓글 서비스를 추가 할 예정입니다. 편향적인 정보 전달이 아니라 양방향 소통 가능한 커뮤니티로 발전 할 예정입니다.
      

4. 디렉터리 구조

```bash
.
├── SERVER
│   ├── Dockerfile
│   ├── README.md
│   ├── appspec.yml
│   ├── build.gradle
│   ├── docker-compose.yaml
│   ├── document
│   │   ├── area.xlsx
│   │   ├── course.xlsx
│   │   ├── restaurant.xlsx
│   │   └── tourSpot.xlsx
│   ├── gradle
│   │   └── wrapper
│   │       ├── gradle-wrapper.jar
│   │       └── gradle-wrapper.properties
│   ├── gradlew
│   ├── gradlew.bat
│   ├── scripts
│   │   ├── start.sh
│   │   └── stop.sh
│   ├── settings.gradle
│   └── src
│       ├── main
│       │   └── java
│       │       └── com
│       │           └── example
│       │               └── hackdemo
│       │                   ├── HackDemoApplication.java
│       │                   ├── auth
│       │                   │   ├── AuthController.java
│       │                   │   ├── CustomOAuth2UserService.java
│       │                   │   └── OAuth2AuthenticationSuccessHandler.java
│       │                   ├── config
│       │                   │   ├── S3Config.java
│       │                   │   └── SecurityConfig.java
│       │                   ├── controller
│       │                   │   ├── AreaController.java
│       │                   │   ├── CourseController.java
│       │                   │   ├── CourseItemController.java
│       │                   │   ├── FavoriteController.java
│       │                   │   ├── FavoriteResponse.java
│       │                   │   ├── FileUploadController.java
│       │                   │   ├── RestaurantController.java
│       │                   │   ├── TourSpotController.java
│       │                   │   └── UserController.java
│       │                   ├── dto
│       │                   │   ├── AreaDTO.java
│       │                   │   ├── CourseDTO.java
│       │                   │   ├── CourseItemDTO.java
│       │                   │   ├── FavoriteCourseDTO.java
│       │                   │   ├── RestaurantDTO.java
│       │                   │   └── TourSpotDTO.java
│       │                   ├── excel
│       │                   │   ├── Excel.java
│       │                   │   ├── ExcelRepository.java
│       │                   │   └── ExcelService.java
│       │                   ├── jwt
│       │                   │   ├── JwtAuthenticationFilter.java
│       │                   │   ├── JwtTokenProvider.java
│       │                   │   └── UserToken.java
│       │                   ├── model
│       │                   │   ├── Area.java
│       │                   │   ├── Course.java
│       │                   │   ├── CourseCompletion.java
│       │                   │   ├── CourseItem.java
│       │                   │   ├── CustomUserDetails.java
│       │                   │   ├── Favorite.java
│       │                   │   ├── Photo.java
│       │                   │   ├── Restaurant.java
│       │                   │   ├── TourSpot.java
│       │                   │   └── User.java
│       │                   ├── repository
│       │                   │   ├── AreaRepository.java
│       │                   │   ├── CourseCompletionRepository.java
│       │                   │   ├── CourseItemRepository.java
│       │                   │   ├── CourseRepository.java
│       │                   │   ├── FavoriteRepository.java
│       │                   │   ├── PhotoRepository.java
│       │                   │   ├── RestaurantRepository.java
│       │                   │   ├── TourSpotRepository.java
│       │                   │   ├── UserRepository.java
│       │                   │   └── UserTokenRepository.java
│       │                   └── service
│       │                       ├── AreaService.java
│       │                       ├── CourseCompletionService.java
│       │                       ├── CourseItemService.java
│       │                       ├── CourseService.java
│       │                       ├── CustomUserDetailsService.java
│       │                       ├── FavoriteService.java
│       │                       ├── RestaurantService.java
│       │                       ├── S3Service.java
│       │                       ├── TourSpotService.java
│       │                       └── UserService.java
│       └── test
│           └── java
│               └── com
│                   └── example
│                       └── hackdemo
│                           └── HackDemoApplicationTests.java
├── client
│   ├── README.md
│   ├── analysis_options.yaml
│   ├── android
│   │   ├── app
│   │   │   ├── build.gradle
│   │   │   └── src
│   │   │       ├── debug
│   │   │       │   └── AndroidManifest.xml
│   │   │       ├── main
│   │   │       │   ├── AndroidManifest.xml
│   │   │       │   ├── ic_launcher-playstore.png
│   │   │       │   ├── kotlin
│   │   │       │   │   └── dev
│   │   │       │   │       └── insd
│   │   │       │   │           └── heron
│   │   │       │   │               └── MainActivity.kt
│   │   │       │   └── res
│   │   │       │       ├── drawable
│   │   │       │       │   └── launch_background.xml
│   │   │       │       ├── drawable-v21
│   │   │       │       │   └── launch_background.xml
│   │   │       │       ├── mipmap-anydpi-v26
│   │   │       │       │   ├── ic_launcher.xml
│   │   │       │       │   └── ic_launcher_round.xml
│   │   │       │       ├── mipmap-hdpi
│   │   │       │       │   ├── ic_launcher.webp
│   │   │       │       │   ├── ic_launcher_foreground.webp
│   │   │       │       │   └── ic_launcher_round.webp
│   │   │       │       ├── mipmap-mdpi
│   │   │       │       │   ├── ic_launcher.webp
│   │   │       │       │   ├── ic_launcher_foreground.webp
│   │   │       │       │   └── ic_launcher_round.webp
│   │   │       │       ├── mipmap-xhdpi
│   │   │       │       │   ├── ic_launcher.webp
│   │   │       │       │   ├── ic_launcher_foreground.webp
│   │   │       │       │   └── ic_launcher_round.webp
│   │   │       │       ├── mipmap-xxhdpi
│   │   │       │       │   ├── ic_launcher.webp
│   │   │       │       │   ├── ic_launcher_foreground.webp
│   │   │       │       │   └── ic_launcher_round.webp
│   │   │       │       ├── mipmap-xxxhdpi
│   │   │       │       │   ├── ic_launcher.webp
│   │   │       │       │   ├── ic_launcher_foreground.webp
│   │   │       │       │   └── ic_launcher_round.webp
│   │   │       │       ├── values
│   │   │       │       │   ├── ic_launcher_background.xml
│   │   │       │       │   └── styles.xml
│   │   │       │       └── values-night
│   │   │       │           └── styles.xml
│   │   │       └── profile
│   │   │           └── AndroidManifest.xml
│   │   ├── build
│   │   │   └── ios
│   │   │       └── XCBuildData
│   │   │           └── PIFCache
│   │   │               └── project
│   │   │                   └── PROJECT@v11_mod=1725411714.5015173_hash=bfdfe7dc352907fc980b868725387e98plugins=1OJSG6M1FOV3XYQCBH7Z29RZ0FPR9XDE1-json
│   │   ├── build.gradle
│   │   ├── gradle
│   │   │   └── wrapper
│   │   │       └── gradle-wrapper.properties
│   │   ├── gradle.properties
│   │   └── settings.gradle
│   ├── assets
│   │   ├── examples
│   │   │   └── course_map.png
│   │   ├── fonts
│   │   │   ├── HeronIcons.ttf
│   │   │   ├── Pretendard-Black.otf
│   │   │   ├── Pretendard-Bold.otf
│   │   │   ├── Pretendard-ExtraBold.otf
│   │   │   ├── Pretendard-ExtraLight.otf
│   │   │   ├── Pretendard-Light.otf
│   │   │   ├── Pretendard-Medium.otf
│   │   │   ├── Pretendard-Regular.otf
│   │   │   ├── Pretendard-SemiBold.otf
│   │   │   └── Pretendard-Thin.otf
│   │   └── images
│   │       ├── gallery_empty.svg
│   │       ├── google_logo.svg
│   │       ├── profile_pic.png
│   │       └── profile_pic_dark.png
│   ├── ios
│   │   ├── Flutter
│   │   │   ├── AppFrameworkInfo.plist
│   │   │   ├── Debug.xcconfig
│   │   │   └── Release.xcconfig
│   │   ├── Podfile
│   │   ├── Podfile.lock
│   │   ├── Runner
│   │   │   ├── AppDelegate.swift
│   │   │   ├── Assets.xcassets
│   │   │   │   ├── AppIcon.appiconset
│   │   │   │   │   ├── 100.png
│   │   │   │   │   ├── 1024.png
│   │   │   │   │   ├── 114.png
│   │   │   │   │   ├── 120.png
│   │   │   │   │   ├── 144.png
│   │   │   │   │   ├── 152.png
│   │   │   │   │   ├── 167.png
│   │   │   │   │   ├── 180.png
│   │   │   │   │   ├── 20.png
│   │   │   │   │   ├── 29.png
│   │   │   │   │   ├── 40.png
│   │   │   │   │   ├── 50.png
│   │   │   │   │   ├── 57.png
│   │   │   │   │   ├── 58.png
│   │   │   │   │   ├── 60.png
│   │   │   │   │   ├── 72.png
│   │   │   │   │   ├── 76.png
│   │   │   │   │   ├── 80.png
│   │   │   │   │   ├── 87.png
│   │   │   │   │   └── Contents.json
│   │   │   │   └── LaunchImage.imageset
│   │   │   │       ├── Contents.json
│   │   │   │       ├── LaunchImage.png
│   │   │   │       ├── LaunchImage@2x.png
│   │   │   │       ├── LaunchImage@3x.png
│   │   │   │       └── README.md
│   │   │   ├── Base.lproj
│   │   │   │   ├── LaunchScreen.storyboard
│   │   │   │   └── Main.storyboard
│   │   │   ├── Info.plist
│   │   │   ├── Runner-Bridging-Header.h
│   │   │   └── Runner.entitlements
│   │   ├── Runner.xcodeproj
│   │   │   ├── project.pbxproj
│   │   │   ├── project.xcworkspace
│   │   │   │   ├── contents.xcworkspacedata
│   │   │   │   └── xcshareddata
│   │   │   │       ├── IDEWorkspaceChecks.plist
│   │   │   │       └── WorkspaceSettings.xcsettings
│   │   │   └── xcshareddata
│   │   │       └── xcschemes
│   │   │           └── Runner.xcscheme
│   │   ├── Runner.xcworkspace
│   │   │   ├── contents.xcworkspacedata
│   │   │   └── xcshareddata
│   │   │       ├── IDEWorkspaceChecks.plist
│   │   │       └── WorkspaceSettings.xcsettings
│   │   ├── RunnerTests
│   │   │   └── RunnerTests.swift
│   │   └── build
│   │       └── XCBuildData
│   │           ├── 48e3cb1f2b6a8c95179a1501ecb2c9c1.xcbuilddata
│   │           │   ├── build-request.json
│   │           │   ├── description.msgpack
│   │           │   ├── manifest.json
│   │           │   ├── target-graph.txt
│   │           │   └── task-store.msgpack
│   │           └── ce77329fb5a1fb98ac1962f8fe6fc20c.xcbuilddata
│   │               ├── build-request.json
│   │               ├── description.msgpack
│   │               ├── manifest.json
│   │               ├── target-graph.txt
│   │               └── task-store.msgpack
│   ├── l10n.yaml
│   ├── lib
│   │   ├── constants
│   │   │   ├── map.dart
│   │   │   ├── preferences.dart
│   │   │   ├── request.dart
│   │   │   └── webview.dart
│   │   ├── l10n
│   │   │   ├── app_en.arb
│   │   │   └── app_ko.arb
│   │   ├── main.dart
│   │   ├── models
│   │   │   ├── auth
│   │   │   │   ├── apple.dart
│   │   │   │   ├── google.dart
│   │   │   │   └── types.dart
│   │   │   ├── courses
│   │   │   │   ├── courses.dart
│   │   │   │   ├── details
│   │   │   │   │   ├── details.dart
│   │   │   │   │   └── missions
│   │   │   │   │       └── details.dart
│   │   │   │   └── types.dart
│   │   │   ├── info
│   │   │   │   └── types.dart
│   │   │   ├── map
│   │   │   │   ├── map.dart
│   │   │   │   └── types.dart
│   │   │   ├── types.dart
│   │   │   └── user.dart
│   │   ├── screens
│   │   │   ├── courses
│   │   │   │   ├── courses.dart
│   │   │   │   ├── details
│   │   │   │   │   ├── details.dart
│   │   │   │   │   └── widgets
│   │   │   │   │       ├── bottom.dart
│   │   │   │   │       ├── dialog.dart
│   │   │   │   │       ├── header.dart
│   │   │   │   │       ├── list.dart
│   │   │   │   │       └── modifier.dart
│   │   │   │   └── widgets
│   │   │   │       ├── filter.dart
│   │   │   │       └── list.dart
│   │   │   ├── error
│   │   │   │   └── error.dart
│   │   │   ├── home.dart
│   │   │   ├── info
│   │   │   │   ├── details
│   │   │   │   │   └── details.dart
│   │   │   │   ├── info.dart
│   │   │   │   └── widgets
│   │   │   │       └── filter.dart
│   │   │   ├── map
│   │   │   │   ├── map.dart
│   │   │   │   └── widgets
│   │   │   │       ├── buttons.dart
│   │   │   │       ├── filter.dart
│   │   │   │       ├── floating.dart
│   │   │   │       ├── googlemap.dart
│   │   │   │       └── inherit.dart
│   │   │   └── more
│   │   │       ├── more.dart
│   │   │       ├── policy
│   │   │       │   └── policy.dart
│   │   │       ├── terms
│   │   │       │   └── terms.dart
│   │   │       └── widgets
│   │   │           ├── app.dart
│   │   │           ├── dialog.dart
│   │   │           ├── etc.dart
│   │   │           ├── prefs.dart
│   │   │           └── profile.dart
│   │   ├── utilities
│   │   │   ├── auth.dart
│   │   │   ├── device_id.dart
│   │   │   ├── latlng.dart
│   │   │   └── ripple.dart
│   │   └── widgets
│   │       ├── appbar
│   │       │   ├── appbar.dart
│   │       │   └── status.dart
│   │       ├── button
│   │       │   ├── button.dart
│   │       │   ├── icon.dart
│   │       │   ├── like.dart
│   │       │   └── text.dart
│   │       ├── chip
│   │       │   └── chip.dart
│   │       ├── filter
│   │       │   └── filter.dart
│   │       ├── label
│   │       │   ├── course.dart
│   │       │   ├── food.dart
│   │       │   ├── label.dart
│   │       │   └── spot.dart
│   │       ├── list
│   │       │   ├── items.dart
│   │       │   └── list.dart
│   │       ├── navigation
│   │       │   └── navigation.dart
│   │       ├── other
│   │       │   ├── empty.dart
│   │       │   ├── future.dart
│   │       │   ├── image.dart
│   │       │   ├── sheet.dart
│   │       │   └── webview.dart
│   │       ├── place
│   │       │   ├── header.dart
│   │       │   ├── place.dart
│   │       │   └── table.dart
│   │       ├── profile
│   │       │   └── pic.dart
│   │       ├── scroll
│   │       │   └── scroll.dart
│   │       ├── signin
│   │       │   ├── apple.dart
│   │       │   ├── google.dart
│   │       │   └── signin.dart
│   │       └── theme
│   │           ├── icon.dart
│   │           ├── label.dart
│   │           ├── prefs.dart
│   │           └── theme.dart
│   ├── pubspec.lock
│   ├── pubspec.yaml
│   └── test
│       └── widget_test.dart
└── info
   ├── README.md
   ├── messages
   │   ├── en.json
   │   └── ko.json
   ├── next.config.mjs
   ├── package.json
   ├── public
   │   ├── icons
   │   │   ├── android-icon-144x144.png
   │   │   ├── android-icon-192x192.png
   │   │   ├── android-icon-36x36.png
   │   │   ├── android-icon-48x48.png
   │   │   ├── android-icon-72x72.png
   │   │   ├── android-icon-96x96.png
   │   │   ├── apple-icon-114x114.png
   │   │   ├── apple-icon-120x120.png
   │   │   ├── apple-icon-144x144.png
   │   │   ├── apple-icon-152x152.png
   │   │   ├── apple-icon-180x180.png
   │   │   ├── apple-icon-57x57.png
   │   │   ├── apple-icon-60x60.png
   │   │   ├── apple-icon-72x72.png
   │   │   ├── apple-icon-76x76.png
   │   │   ├── apple-icon-precomposed.png
   │   │   ├── apple-icon.png
   │   │   ├── browserconfig.xml
   │   │   ├── favicon-16x16.png
   │   │   ├── favicon-32x32.png
   │   │   ├── favicon-96x96.png
   │   │   ├── favicon.ico
   │   │   ├── ms-icon-144x144.png
   │   │   ├── ms-icon-150x150.png
   │   │   ├── ms-icon-310x310.png
   │   │   └── ms-icon-70x70.png
   │   └── manifest.json
   ├── src
   │   ├── app
   │   │   ├── (pages)
   │   │   │   ├── [id]
   │   │   │   │   ├── notion.tsx
   │   │   │   │   ├── opengraph-image.png
   │   │   │   │   ├── page.module.css
   │   │   │   │   └── page.tsx
   │   │   │   ├── channel.tsx
   │   │   │   ├── notion.tsx
   │   │   │   ├── page.module.css
   │   │   │   ├── page.tsx
   │   │   │   ├── privacy
   │   │   │   │   └── page.tsx
   │   │   │   └── terms
   │   │   │       └── page.tsx
   │   │   ├── 404.tsx
   │   │   ├── error.css
   │   │   ├── error.tsx
   │   │   └── layout.tsx
   │   ├── components
   │   │   ├── button
   │   │   │   ├── button.module.css
   │   │   │   └── index.tsx
   │   │   ├── header
   │   │   │   ├── header.module.css
   │   │   │   └── index.tsx
   │   │   ├── label
   │   │   │   ├── index.tsx
   │   │   │   └── label.module.css
   │   │   ├── locale
   │   │   │   └── locale.tsx
   │   │   ├── notion
   │   │   │   ├── index.tsx
   │   │   │   ├── notion.module.css
   │   │   │   └── renderer.tsx
   │   │   └── time
   │   │       ├── index.tsx
   │   │       └── time.module.css
   │   ├── constants
   │   │   ├── notion.ts
   │   │   └── webview.ts
   │   ├── i18n.ts
   │   ├── styles
   │   │   ├── globals.css
   │   │   └── notion.css
   │   └── utilities
   │       ├── getBrightness.ts
   │       ├── getDateTime.ts
   │       └── isValidApp.ts
   ├── tsconfig.json
   ├── vercel.json
   └── yarn.lock
```

## 4. 설치 및 사용 방법

### Flutter App (./client)
1. Flutter SDK를 설치합니다.
2. Google Cloud Platform에서 iOS, Android 각각의 API 키, OAuth Client를 생성합니다. 클라우드 프로젝트가 없다면 생성합니다.
3. API 키는 `android/local.properties`, `ios/Flutter/Secrets.xcconfig`에 각각 `GMS_API_KEY`, `gms.api.key`로 설정합니다.
4. [google_sign_in](https://pub.dev/packages/google_sign_in) 패키지를 참고하여 Android, iOS의 OAuth 인증 파일을 배치합니다.
5. `flutter run`으로 앱을 실행합니ㅏㄷ.

### Info App (./info)
1. yarn을 통해 의존 모듈을 설치합니다.
```bash
yarn install
```

2. 환경 변수를 설정합니다.
```plaintext
APP_BUNDLE_ID="dev.insd.heron"
APP_STORE_ID="6639612757"
COLLECTION_ID="ce0ed34714004a97b8156d5d824c8160"
PRIVACY_ID="a17c663c6e2246fbae1df3c9f66a2ba3"
TERMS_ID="ddeafde8d04f420f88620bcde30dcf5a"
```

3. 프로젝트를 실행합니다.
```
yarn dev
```

## 5. 소개 및 시연 영상

[![YouTube](http://i.ytimg.com/vi/fgFu48xAqzw/hqdefault.jpg)](https://www.youtube.com/watch?v=fgFu48xAqzw)

## 6. 팀 소개
    
- 배명환 - 디자인학과 - 디자인 및 프로젝트 매니저 - [dragonscott00@naver.com](mailto:dragonscott00@naver.com)
- 이창희 - 미디어커뮤니케이션학과 - 기획 - [ckdgml0904@naver.com](mailto:ckdgml0904@naver.com)
- 조용진 - 토목공학과 - 백엔드 서버 개발 - [whdydwls1595@naver.com](mailto:whdydwls1595@naver.com)
- 황인성 - 정보컴퓨터공학부 - 애플리케이션 개발 - [me@insd.dev](mailto:me@insd.dev)
    
## 7. 해커톤 참여후기

1. 배명환
   
   > 여름방학 동안 참여한 프로젝트는 제게 큰 의미가 있었습니다. 훌륭한 팀원들과 함께 협력하며 다양한 아이디어를 탐색할 수 있었고, 실제 문제를 해결하는 과정에서 많은 교훈을 얻었습니다. 디자인을 통해 사용자 경험을 향상시키는 데 기여할 수 있어 매우 뿌듯했습니다. 결과에 관계없이, 이 경험은 제 전문성을 한 단계 끌어올리는 데 큰 도움이 되었고, 앞으로의 작업에도 긍정적인 영향을 미칠 것이라고 믿습니다.
   
2. 이창희
   
   > 여름방학 기간을 덕분에 알차게 보낼 수 있었고, 너무 좋은 팀원들을 만나 의미 있는 결과물을 만들 수 있어 기뻤습니다. 실제 주변에서 겪는 문제를 해결하기 위한 아이디어를 제시하고, 디벨롭하는 과정에서 많은 인사이트를 얻을 수 있었고, 결과를 떠나 의미 있었던 활동이었습니다.
   
3. 조용진
   
   > 팀원들과 함께 개발하는 동안, 평소에는 경험하지 못한 다양한 부분을 배웠고, 실제 배포 과정에서 예상치 못한 오류들이 많았지만 팀원들과 함께 이를 해결하며 직무에 대한 이해도 크게 높아졌습니다. 시간이 촉박해 혼자였다면 어려웠겠지만, 팀원들과의 협업 덕분에 잘 마무리할 수 있었습니다. 저 스스로가 많이 성장 했다고 느껴지는 시간이었습니다.
   
4. 황인성
   
   > 항상 애플리케이션 개발을 경험하고 싶었던 저에게 이번 해커톤은 매우 의미있는 경험이었습니다. 네이티브 앱에서만 사용할 수 있는 다양한 SDK도 사용해 보고, 백엔드와 앱 간 통신 채널도 마련해보고, 앱과 유연하게 통합되는 웹뷰도 구성해 보고, 팀 프로젝트 경험도 쌓을 수 있었습니다. 혼자서 고생한 것이 아니라 팀원이 있었기에 여기까지 올 수 있다고 생각합니다.
