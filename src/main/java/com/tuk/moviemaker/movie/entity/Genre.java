package com.tuk.moviemaker.movie.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Genre {
    ACTION("액션"),
    COMEDY("코미디"),
    DRAMA("드라마"),
    FANTASY("판타지"),
    HORROR("호러"),
    ROMANCE("로맨스"),
    THRILLER("스릴러"),
    MYSTERY("미스터리"),
    SCIFI("SF"),
    DOCUMENTARY("다큐멘터리"),
    ANIMATION("애니메이션"),
    ADVENTURE("어드벤처"),
    CRIME("범죄"),
    BIOGRAPHY("전기"),
    HISTORY("역사"),
    MUSICAL("뮤지컬"),
    WAR("전쟁"),
    WESTERN("서부");

    private final String name;
}
