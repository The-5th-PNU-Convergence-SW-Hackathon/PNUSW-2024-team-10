package com.example.hackdemo.controller;

class FavoriteResponse {
    private boolean isFavorite;

    public FavoriteResponse(boolean isFavorite) {
        this.isFavorite = isFavorite;
    }

    public boolean isFavorite() {
        return isFavorite;
    }
}
