show tables;

CREATE TABLE EstateFile (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    estate INT UNSIGNED NOT NULL COMMENT '물건 ID',
    mime VARCHAR(127) NOT NULL COMMENT '파일 종류',
    orgname VARCHAR(127) NOT NULL COMMENT '원래 파일명',
    sysname VARCHAR(127) NOT NULL COMMENT '시스템 저장 파일명',
    filepath VARCHAR(127) NOT NULL COMMENT '저장 위치',
    filesize INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '파일크기',
    deldate TIMESTAMP NULL COMMENT '삭제 일시',
  PRIMARY KEY (id),
  FOREIGN KEY fk_EstateFile_Estate(estate)
    references Estate(id) on delete cascade
);

CREATE TABLE `Agency` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '복덕방 이름',
  `ceo` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '대표자 이름',
  `tel` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '대표 전화번호',
  `etctel` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기타 전화번호',
  `regno` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '등록번호',
  `zipcode` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '우편번호',
  `addr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '주소',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='복덕방';
