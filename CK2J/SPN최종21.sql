--table 삭제
drop table qna_reply;
drop table qna;
drop table notice;
drop table userOrder_return;


drop table userOrder_detail;
drop table review_reply;
drop table product_review;
drop table user_order;
drop table deliver_address;
drop table userTable;
drop table cart;
drop table nonuserOrder_return;

drop table nonuserOrder_detail;
drop table nonuser_order;
drop table product_opt;
drop table product_d_img;
drop table product_t_img;
drop table product;

-- product/qna 삭제 --
drop sequence product_review_seq;
drop sequence review_reply_seq;
drop sequence product_seq;
drop sequence cart_seq;
drop sequence product_opt_seq;

drop sequence qna_seq;
drop sequence qna_reply_seq;
drop sequence notice_seq;

-- user/nonuser 삭제 --
drop sequence nonuserOrder_detail_seq;
drop sequence nonuserOrder_return_seq;

drop sequence nonuser_order_seq;

drop sequence userOrder_detail_seq;
drop sequence userOrder_return_seq;
drop sequence user_idx_seq;
drop sequence user_order_seq;


-- product/qna 생성 --
create sequence product_review_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence review_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_opt_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence cart_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

create sequence qna_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence qna_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence notice_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
------------------------------------------------------------------------

-- user/nonuser 생성 --
create sequence nonuserOrder_detail_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence nonuserOrder_return_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

create sequence nonuser_order_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

create sequence userOrder_detail_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence userOrder_return_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence user_idx_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence user_order_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

---------------------------------------------------------------------------------------------------------------

-- user테이블 생성 --

CREATE TABLE userTable (
	user_id	varchar2(30)	NOT NULL primary key,
	user_idx	number	DEFAULT user_idx_seq.nextval	NOT NULL,
	user_pwd	varchar2(255)		NOT NULL,
	user_name	varchar2(20)		NOT NULL,
	user_phone	varchar2(20)		NOT NULL,
	user_email	varchar2(50)	    NOT NULL,
	email_check	varchar2(10)		check(email_check in('Y','N')) NOT NULL,
	user_role	varchar2(20)	    default 'user' check(user_role in('admin','user'))	NOT NULL,
	user_grade	varchar2(20)		default 'bronze' check(user_grade in('bronze','silver','gold')) not null,
	user_insertDate	date	        DEFAULT sysdate	NOT NULL,
    user_birth    date              NOT NULL,
    user_gender varchar2(20)        check(user_gender in('여성','남성')) NOT NULL
);

CREATE TABLE qna (
   qna_idx           number               default qna_seq.nextval  primary key,
   user_id           varchar2(30)      NOT NULL,
    qna_password    varchar2(100)       ,
    qna_title       varchar2(300)       not null,
    qna_content     varchar2(4000)      not null,
    qna_writeDate   date                default sysdate not null,
    qna_secret      varchar2(10)        default 'N' check(qna_secret in('Y','N')) NOT NULL,
    
    constraint qna_userTable
    foreign key(user_id)
    references userTable(user_id)
);

create table qna_reply (
    qna_reply_idx       number          default qna_reply_seq.nextval primary key,
    qna_idx             number          not null,
    content             varchar2(3000)  not null,
    writing_date        date            default sysdate not null,
    
    constraint qna_reply_qna
    foreign key(qna_idx)
    references qna(qna_idx)
);

create table notice (
    notice_idx          number          default notice_seq.nextval primary key,
    notice_writer       varchar2(100)   not null,
    notice_title        varchar2(300)   not null,
    notice_content      varchar2(4000)  not null,
    notice_writeDate    date            default sysdate not null,
    show_check          varchar2(10)    default 'N' check(show_check in('Y', 'N')) not null
);

-- userOrder table 생성
CREATE TABLE user_order (
	user_order_idx	number	DEFAULT user_order_seq.nextval primary key,
	user_id	varchar2(30)	NOT NULL,
	order_date	date	DEFAULT sysdate 	NOT NULL,
	address1	varchar2(20)	NOT NULL,
	address2	varchar2(50)	NOT NULL,
	address3	varchar2(50)	NOT NULL,
	order_total_price	number	NOT NULL,
	receiver_name	varchar2(20)	NOT NULL,
	receiver_phone	varchar2(20)	NOT NULL,
    status_for_admin    varchar2(50),
    
    constraint user_order_user
    foreign key(user_id)
    references userTable(user_id)
);
-- deliverAddress table 생성

CREATE TABLE deliver_address (
	user_id	varchar2(30)	NOT NULL,
	user_address1	varchar2(20)	NOT NULL,
	user_address2	varchar2(200)	NOT NULL,
	user_address3	varchar2(200)	NOT NULL,
    
    constraint deliver_address_userTable
    FOREIGN key(user_id)
    REFERENCES userTable(user_id)
);
--product table 생성
create table product (
    product_idx             number              default product_seq.nextval  primary key,
    product_code            varchar2(20)        not null,
    product_name            varchar2(200)        not null,
    product_price           number              not null,
    product_desc            varchar2(3000)      ,
    product_date            date                default sysdate not null,
    product_hits            number              default 0 not null,
    delete_check            varchar2(2)         default 'n' not null,
    show_check              varchar2(10)        default 'show' not null   
);

--썸네일 테이블 생성
create table product_t_img (
    product_t_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_t_img_product
    foreign key(product_idx)
    references product(product_idx)
);

--상세이미지 테이블 생성
create table product_d_img (
    product_d_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_d_img_product
    foreign key(product_idx)
    references product(product_idx)
);

--제품 옵션 테이블 생성
create table product_opt (
    product_opt_idx           number            default product_opt_seq.nextval  primary key,
    product_idx             number              not null,
    product_size            varchar2(50)        not null,
    product_color           varchar2(100)       not null,
    product_stock           number              default 0 not null,
    
    constraint product_opt_product
    foreign key(product_idx)
    references product(product_idx)
);

--장바구니 테이블 생성
create table cart (
    cart_idx                number            default cart_seq.nextval  primary key,
    product_opt_idx         number            not null,
    cart_value              varchar2(30)      not null,
    product_count           number            default 0 not null, --제품수량인데 0이면 안되나?
    
    constraint cart_product_opt
    foreign key(product_opt_idx)
    references product_opt(product_opt_idx)
);

--제품리뷰 테이블 생성
create table product_review (
    product_review_idx         number           default product_review_seq.nextval  primary key,
    product_opt_idx            number           not null,
    user_id                    varchar2(30)     not null,
    rate                       number           not null,
    content                    varchar2(3000)   not null,
    writing_date               date             default sysdate not null,
    delete_check               varchar2(2)      default 'n' not null,
    
    constraint product_review_product_opt
    foreign key(product_opt_idx)
    references product_opt(product_opt_idx),
    
    constraint product_review_userTable
    foreign key(user_id)
    references userTable(user_id)
);

--리뷰에 답글 테이블 생성
create table review_reply (
    review_reply_idx           number           default product_review_seq.nextval  primary key,
    product_review_idx         number           not null,
    content                    varchar2(3000)     not null,
    writing_date               date             default sysdate not null,
    
    constraint review_reply_product_review
    foreign key(product_review_idx)
    references product_review(product_review_idx)
);
--userOrder_detail 테이블 생성
CREATE TABLE userOrder_detail (
	userOrder_detail_idx	number DEFAULT userOrder_detail_seq.nextval primary key,
	product_opt_idx	number	not null,
	user_order_idx	number	not null,
	product_count	number	NOT NULL,
	product_price	number	NOT NULL,
	order_detail_status	varchar2(50) default '주문확인중',
    
    constraint userOrder_detail_opt_idx
    foreign key (product_opt_idx)
    REFERENCES product_opt(product_opt_idx),
    
    constraint userOrder_detail_user_order_idx
    foreign key (user_order_idx)
    REFERENCES user_order(user_order_idx)
    on delete cascade
);

--userOrder Return 테이블 생성

CREATE TABLE userOrder_return (
	userOrder_return_idx	number	DEFAULT userOrder_return_seq.nextval primary key,
	userOrder_detail_idx	number	NOT NULL,
	returnType	varchar2(20)	not null,
	return_reason	varchar2(3000)	NOT NULL,
	bankName	varchar2(30)	,
	bankAccountName	varchar2(20)	,
	bankAccountNumber	number		,
	    
    constraint userOrder_return_userOrder_detail
    FOREIGN key(userOrder_detail_idx)
    REFERENCES userOrder_detail(userOrder_detail_idx)
  
);


--nonuser Order
CREATE TABLE nonuser_order (
	nonuser_order_idx	number	DEFAULT nonuser_order_seq.nextval primary key,
	order_date	date	DEFAULT sysdate	NOT NULL,
	address1	varchar2(20)		NOT NULL,
	address2	varchar2(50)		NOT NULL,
	address3	varchar2(50)		NOT NULL,
    order_total_price number       NOT NULL,
	receiver_name	varchar2(20)		NOT NULL,
	receiver_phone	varchar2(20)		NOT NULL,                  
    nonuser_pwd             varchar2(255)        NOT NULL,
    status_for_admin    varchar2(50)
);
--nonuserOrder detail
CREATE TABLE nonuserOrder_detail (
	nonuserOrder_detail_idx	number	DEFAULT nonuserOrder_detail_seq.nextval primary key,
	product_opt_idx         	number	NOT NULL,
	nonuser_order_idx	    number  NOT NULL,
	
    product_count	number		NOT NULL,
	product_price	number		NOT NULL,
	order_detail_status	varchar2(50) default '주문확인중',
    
    constraint fk_nonuser_order  --  제약조건의 이름
    foreign key(nonuser_order_idx)           --  외래키가될 컬럼
    REFERENCES nonuser_order(nonuser_order_idx)
    on delete cascade,    --  외래키가 참조하는 테이블 (컬럼)
           
    constraint fk_product_opt  --  제약조건의 이름
    foreign key(product_opt_idx)           --  외래키가될 컬럼
    REFERENCES product_opt(product_opt_idx)    --  외래키가 참조하는 테이블 (컬럼)
       --  부모키가 삭제될 경우 처리  // 상품이 제거되면 매출건도 사라진다.
);
--nonuserOrder_return
CREATE TABLE nonuserOrder_return (
	nonuserOrder_return_idx	number	DEFAULT nonuserOrder_return_seq.nextval primary key,
	nonuserOrder_detail_idx	number NOT NULL,
	returnType 	varchar2(20) 		NOT NULL,
	return_reason	varchar2(3000)		NOT NULL,
	bankName	varchar2(30)	,
	bankAccountName	varchar2(20)	,
	bankAccountNumber	number		,
	
    constraint fk_nonuserOrder_detail  --  제약조건의 이름
    foreign key(nonuserOrder_detail_idx)           --  외래키가될 컬럼
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  외래키가 참조하는 테이블 (컬럼)
);

insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('admin','dc86063e298488dd6f4392d6e2d2e849eb6012750f0ad78f55367f8daa12080d9c9f386db5562f47deca4b2ad882f1b2ed30a809404d9e04aa92b1f6526269e9','관리자','1995-05-30','남성','010-0000-0000','ericjung759@naver.com','N','admin','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('UnwtWO37','test1234!@','홍문철','1982-01-13','남성','010-3406-5339','UnwtWO37@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fZrLdG95','test1234!@','신성숙','2000-10-23','남성','010-4961-6980','fZrLdG95@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('test','Test123!@#','테스트정철현','1995-05-30','남성','010-1234-5678','ersf34@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fwxLHU60','test1234!@','허은경','1995-02-02','남성','010-7370-4980','fwxLHU60@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('CLeLwR82','test1234!@','강우태','1994-03-15','남성','010-7613-2290','CLeLwR82@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('rlReFg93','test1234!@','전명욱','1996-01-22','남성','010-6748-4697','rlReFg93@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wzBsVc87','test1234!@','사공승기','1996-02-15','남성','010-2986-4989','wzBsVc87@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('uWgSgq70','test1234!@','백광호','1995-01-04','남성','010-6455-6164','uWgSgq70@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pYHZAb59','test1234!@','노용철','1999-12-02','남성','010-2668-7560','pYHZAb59@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dYzsUd66','test1234!@','박승근','1981-08-07','남성','010-4780-8207','dYzsUd66@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zPVaYB33','test1234!@','황정혁','1997-01-04','남성','010-7809-4157','zPVaYB33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('YGshpn97','test1234!@','백명선','1990-11-28','남성','010-4554-7828','YGshpn97@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dUteJB40','test1234!@','안동빈','1987-07-06','남성','010-4124-7184','dUteJB40@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('KgcCXs43','test1234!@','류효민','2002-09-13','남성','010-8742-7149','KgcCXs43@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EOHmJC56','test1234!@','남병하','1995-11-01','남성','010-8857-2235','EOHmJC56@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('DMKnnD87','test1234!@','성유진','1992-10-22','남성','010-3188-6252','DMKnnD87@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('nZeBmC16','test1234!@','안해일','1984-10-26','남성','010-7297-2181','nZeBmC16@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('gpLvvj41','test1234!@','노현경','1997-07-27','남성','010-3823-4594','gpLvvj41@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('rHtSTI72','test1234!@','류준용','1988-11-16','남성','010-7755-7016','rHtSTI72@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('cvsxVu92','test1234!@','남윤준','1988-02-05','남성','010-2900-2104','cvsxVu92@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zDiPIW83','test1234!@','백성호','1999-02-01','남성','010-3525-1417','zDiPIW83@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wwTnsG55','test1234!@','류홍기','1991-10-07','남성','010-8205-7510','wwTnsG55@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ScePkt52','test1234!@','봉유진','1980-10-13','남성','010-7939-7426','ScePkt52@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WKwBhF62','test1234!@','한은하','1995-07-27','남성','010-4782-8225','WKwBhF62@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('OWrOwJ79','test1234!@','사공윤정','1984-08-05','남성','010-5717-2165','OWrOwJ79@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('IHgEAW25','test1234!@','이태석','1991-11-01','남성','010-3082-7436','IHgEAW25@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XcSZni35','test1234!@','문세진','1995-06-12','남성','010-7609-1522','XcSZni35@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('NcSBdD29','test1234!@','김석주','1990-12-10','남성','010-9564-2632','NcSBdD29@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('SrsSEL34','test1234!@','배은우','2003-06-05','남성','010-5998-8609','SrsSEL34@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('glhJAQ84','test1234!@','제갈명숙','1999-03-29','남성','010-4668-3799','glhJAQ84@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('sjKXlm25','test1234!@','류현태','1987-01-28','남성','010-5932-3426','sjKXlm25@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WsjgUg67','test1234!@','황재섭','1981-06-11','여성','010-5540-9783','WsjgUg67@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dwPlKf63','test1234!@','배철순','2000-01-02','여성','010-8854-9691','dwPlKf63@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('IUBYjr86','test1234!@','황보경구','1997-12-12','여성','010-4712-4447','IUBYjr86@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xoFTmj2','test1234!@','정철순','1980-10-03','여성','010-2238-8198','xoFTmj2@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('gBOxjO33','test1234!@','추무열','1990-02-15','여성','010-5257-7485','gBOxjO33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('oNaynr78','test1234!@','풍현승','1988-08-20','남성','010-1050-7727','oNaynr78@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EzMXPG3','test1234!@','정재범','1992-11-06','남성','010-2058-1385','EzMXPG3@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kLUpoq33','test1234!@','하광조','2003-03-09','남성','010-9459-9410','kLUpoq33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pZEoCz88','test1234!@','황철순','1994-12-18','남성','010-8736-9845','pZEoCz88@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('DrOGnG62','test1234!@','노덕수','1992-08-16','남성','010-8841-2706','DrOGnG62@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('VTOjAT49','test1234!@','이현승','1980-06-07','여성','010-3157-2462','VTOjAT49@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XJyCZZ61','test1234!@','서동건','1992-05-07','여성','010-6514-2237','XJyCZZ61@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fcrovy98','test1234!@','문재범','1984-01-20','여성','010-7699-4335','fcrovy98@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EItSUp52','test1234!@','정강민','1992-12-17','여성','010-8484-6762','EItSUp52@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('eDpBpw6','test1234!@','탁무열','1980-09-06','여성','010-9802-4978','eDpBpw6@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wYhyME2','test1234!@','황재섭','1980-03-05','남성','010-2615-7301','wYhyME2@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('JKHESW34','test1234!@','정경택','1998-10-12','남성','010-5931-8894','JKHESW34@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ovRTAz44','test1234!@','장경택','1986-02-05','남성','010-1239-2884','ovRTAz44@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('CsoHlu97','test1234!@','전강민','1985-06-10','남성','010-7768-6226','CsoHlu97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('vZCDbi97','test1234!@','안치원','1985-03-14','남성','010-6681-3192','vZCDbi97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('VTEKpP32','test1234!@','남궁경구','1994-04-28','남성','010-3702-6600','VTEKpP32@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('trOGTA24','test1234!@','전동건','1988-12-27','남성','010-3486-8016','trOGTA24@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('nKpupq15','test1234!@','정동건','1997-10-07','남성','010-3028-4986','nKpupq15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('hESTaB30','test1234!@','추재섭','1994-04-18','남성','010-4660-7437','hESTaB30@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('baNJKX15','test1234!@','양일성','1990-02-09','남성','010-9714-6232','baNJKX15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kEAtoR65','test1234!@','고승헌','1993-11-24','남성','010-9618-1601','kEAtoR65@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wvDnWb84','test1234!@','강무영','2002-10-05','남성','010-6039-6605','wvDnWb84@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WJueMS21','test1234!@','남궁치원','1982-07-09','남성','010-1676-2820','WJueMS21@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ogFdTo20','test1234!@','노치원','1988-02-25','남성','010-6673-8114','ogFdTo20@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('AzPciG70','test1234!@','설치원','1981-04-20','남성','010-9465-5905','AzPciG70@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WzUdCc60','test1234!@','강소라','1999-11-02','남성','010-3267-3406','WzUdCc60@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('mjRDRm11','test1234!@','성잔디','1984-10-19','남성','010-7049-4904','mjRDRm11@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('lAujbT96','test1234!@','이누리','1983-07-25','남성','010-3273-8734','lAujbT96@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kztVZt81','test1234!@','남나라빛','1999-02-27','남성','010-9100-6374','kztVZt81@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xrdGjI5','test1234!@','봉보람','1991-04-09','남성','010-5409-6290','xrdGjI5@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('mheOMS15','test1234!@','표아롱','2002-11-14','남성','010-6144-8937','mheOMS15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HMWkJe42','test1234!@','장이슬','1990-08-11','남성','010-6694-1143','HMWkJe42@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('SVtlop17','test1234!@','최소리','1981-03-08','남성','010-3639-9093','SVtlop17@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dnRFMX55','test1234!@','황하루','1994-07-09','여성','010-8004-9226','dnRFMX55@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ArzZSm10','test1234!@','윤자람','1993-04-10','여성','010-9396-9807','ArzZSm10@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('MZvhZi26','test1234!@','추나비','1984-02-13','여성','010-7436-1360','MZvhZi26@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zPGuUK34','test1234!@','유나리','1986-09-12','여성','010-3822-1037','zPGuUK34@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('qVNwgH95','test1234!@','설아름','1994-07-24','여성','010-4563-1151','qVNwgH95@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('oYAqbb1','test1234!@','서민들레','2003-01-20','여성','010-4149-8492','oYAqbb1@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('jdAuXP97','test1234!@','신가람','1985-05-26','여성','010-5869-3910','jdAuXP97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XaCPzj99','test1234!@','배보람','1995-11-06','여성','010-3160-4273','XaCPzj99@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HeNkgE81','test1234!@','이한샘','1997-06-14','여성','010-9240-5753','HeNkgE81@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('tVXDXC30','test1234!@','장아라','1981-05-28','여성','010-8671-6440','tVXDXC30@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('LStNSZ90','test1234!@','백솔','1995-11-25','여성','010-9553-7800','LStNSZ90@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ernGLF68','test1234!@','봉햇빛','1980-05-11','여성','010-7139-8494','ernGLF68@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kdqLJe48','test1234!@','손기쁨','1990-04-28','여성','010-3777-7355','kdqLJe48@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pkOCwk5','test1234!@','송두리','1986-04-30','여성','010-1605-4019','pkOCwk5@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('yoztKG24','test1234!@','문마음','1999-03-01','여성','010-7310-5059','yoztKG24@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HUTEIN97','test1234!@','윤은샘','1997-05-22','여성','010-2742-3865','HUTEIN97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('hIbeRR98','test1234!@','송구슬','1990-03-07','여성','010-2273-5457','hIbeRR98@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('qolOaA24','test1234!@','류두리','2001-06-15','여성','010-4129-7501','qolOaA24@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('jqfSLv55','test1234!@','정가람','1993-12-07','여성','010-9370-3448','jqfSLv55@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xifHmX30','test1234!@','추초롱','1994-05-01','여성','010-8988-6212','xifHmX30@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('iuXvxb50','test1234!@','제갈하늘','1981-04-24','여성','010-5569-7525','iuXvxb50@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('JpyLGs26','test1234!@','전샘나','1995-01-30','여성','010-7722-3077','JpyLGs26@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('onOzMc39','test1234!@','조다운','1989-09-24','여성','010-3288-1088','onOzMc39@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zoraHk37','test1234!@','오힘찬','1996-01-08','여성','010-1835-1894','zoraHk37@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FvLCIa13','test1234!@','봉샘','1999-01-04','여성','010-8519-4797','FvLCIa13@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('YBKnXk66','test1234!@','서한길','1998-06-11','여성','010-4580-6266','YBKnXk66@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('prCLTb96','test1234!@','노미르','1986-03-26','여성','010-8895-5334','prCLTb96@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('MtUdiA8','test1234!@','남궁나길','1989-02-07','여성','010-1463-2478','MtUdiA8@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FvDhzH99','test1234!@','윤미르','1994-10-27','여성','010-3061-4499','FvDhzH99@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FwGLoS28','test1234!@','봉힘찬','1997-04-09','여성','010-3923-9786','FwGLoS28@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('bOuIGy97','test1234!@','설다운','1980-06-22','여성','010-9356-2723','bOuIGy97@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ixAXRA11','test1234!@','하믿음','1998-01-06','여성','010-5088-4523','ixAXRA11@naver.com','Y','user','bronze');

insert into product(product_code,product_name,product_price) values('m_top','올데이 베이직 티셔츠 -반팔 오버핏',24900);
insert into product(product_code,product_name,product_price) values('m_top','베이직 레이어드 반팔 티셔츠',12900);
insert into product(product_code,product_name,product_price) values('m_top','페브릭 트레이닝 후드',49900);
insert into product(product_code,product_name,product_price) values('m_top','캐쥬얼 레터링 맨투맨',32900);
insert into product(product_code,product_name,product_price) values('m_top','모나미 베이직 맨투맨',19900);
insert into product(product_code,product_name,product_price) values('m_top','뮤즈 베이직 쭈리 맨투맨',27900);
insert into product(product_code,product_name,product_price) values('m_top','올데이 베이직 티셔츠 -긴팔 오버핏',24900);
insert into product(product_code,product_name,product_price) values('m_top','라운드 넥 실켓 티셔츠',19900);
insert into product(product_code,product_name,product_price) values('m_top','데일리 무지 롱슬리브',17900);
insert into product(product_code,product_name,product_price) values('m_top','유넥 네츄럴 롱 슬리브 티셔츠',19900);
insert into product(product_code,product_name,product_price) values('m_top','소프트 라운드 긴팔티',19900);
insert into product(product_code,product_name,product_price) values('m_top','플래닛 발포 맨투맨',44900);
insert into product(product_code,product_name,product_price) values('m_top','리버풀 링클프리 라운드 긴팔티',12900);
insert into product(product_code,product_name,product_price) values('m_top','스탠다드 롱 슬리브',16900);
insert into product(product_code,product_name,product_price) values('m_top','베이직 무지 폴라 티셔츠',27900);
insert into product(product_code,product_name,product_price) values('m_top','리버스 오버 맨투맨',34900);
insert into product(product_code,product_name,product_price) values('m_top','베이직 트위스트 오버긴팔티',34900);
insert into product(product_code,product_name,product_price) values('m_top','8color 데일리 반폴라 니트티',32900);
insert into product(product_code,product_name,product_price) values('m_top','데일리 감탄 티셔츠',15900);
insert into product(product_code,product_name,product_price) values('m_top_20','기모 롱 슬리브 - 2차 리오더',21900);
insert into product(product_code,product_name,product_price) values('m_top','베이직 라운드 긴팔 티셔츠 [아스킨원단]',29900);
insert into product(product_code,product_name,product_price) values('m_top','베이직 폰테 긴팔티',24900);
insert into product(product_code,product_name,product_price) values('m_top','4color 하프넥 니트티',29900);
insert into product(product_code,product_name,product_price) values('m_shoes','2color 리얼 레더 블로퍼(소가죽)',56800);
insert into product(product_code,product_name,product_price) values('m_shoes','2color 언밸런스 슬리퍼',82800);
insert into product(product_code,product_name,product_price) values('m_shoes','3color 코튼스트랩 플립플랍',42800);
insert into product(product_code,product_name,product_price) values('m_shoes','아일랫 더비 클리퍼',52800);
insert into product(product_code,product_name,product_price) values('m_shoes','뉴트럴 스니커즈',49800);
insert into product(product_code,product_name,product_price) values('m_shoes','포인트 스퀘어토 레더 더비 슈즈',64800);
insert into product(product_code,product_name,product_price) values('m_shoes','리얼레더 텍스쳐 스니커즈',101800);
insert into product(product_code,product_name,product_price) values('m_shoes','오딘 레더 페니로퍼',58000);
insert into product(product_code,product_name,product_price) values('m_shoes','스티치 슬릿 블랙 로퍼',117000);
insert into product(product_code,product_name,product_price) values('m_shoes','샌더 첼시부츠',56000);
insert into product(product_code,product_name,product_price) values('m_shoes','런어 메쉬 스니커즈',131000);
insert into product(product_code,product_name,product_price) values('m_shoes','미니멀 독일군 스니커즈',54000);
insert into product(product_code,product_name,product_price) values('m_shoes','로이드 지퍼 캔버스',44000);
insert into product(product_code,product_name,product_price) values('m_shoes','브렌즈 첼시부츠',59900);
insert into product(product_code,product_name,product_price) values('m_shoes','레더 더비 클리퍼',149000);
insert into product(product_code,product_name,product_price) values('m_shoes','페리 스퀘어토 로퍼',64000);
insert into product(product_code,product_name,product_price) values('m_shoes','SS 스티치 더비 슈즈',59900);
insert into product(product_code,product_name,product_price) values('m_shoes','베이직 페니로퍼 - 3차 리오더',57900);
insert into product(product_code,product_name,product_price) values('m_shoes','스티치 더비 로퍼',59900);
insert into product(product_code,product_name,product_price) values('m_shoes','CP 베이직 로우 스니커즈(화이트) - 5차 리오더',39900);
insert into product(product_code,product_name,product_price) values('m_shirts','플레인 코튼 셔츠',39900);
insert into product(product_code,product_name,product_price) values('m_shirts','미니멀 오버 카라 셔츠',42900);
insert into product(product_code,product_name,product_price) values('m_shirts','모던 크롭 셔츠',44900);
insert into product(product_code,product_name,product_price) values('m_shitrs','데일리 타탄 체크 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_shirts','Basic 코튼 셔츠',45900);
insert into product(product_code,product_name,product_price) values('m_shirts','레이 슬럽데님 셔츠',44900);
insert into product(product_code,product_name,product_price) values('m_shirts','루이스 미니멀 셔츠',34900);
insert into product(product_code,product_name,product_price) values('m_shirts','세이즈 포플린 셔츠',29900);
insert into product(product_code,product_name,product_price) values('m_shirts','심플 히든 셔츠',27900);
insert into product(product_code,product_name,product_price) values('m_shirts','6color 스탠다드 셔츠',32900);
insert into product(product_code,product_name,product_price) values('m_shirts','9color 링클프리 오버 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_shirts','7color 링클프리 심플 셔츠',22900);
insert into product(product_code,product_name,product_price) values('m_shirts','심플 링클프리 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_shirts','베이직 옥스포드 셔츠(긴팔타입)',21900);
insert into product(product_code,product_name,product_price) values('m_shirts','베이직 스타일러 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_shirts','9color 링클프리 히든 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_shirts','매니 솔리드 오버셔츠',27900);
insert into product(product_code,product_name,product_price) values('m_shirts','릴렉스 링클프리 셔츠(긴팔타입)',24900);
insert into product(product_code,product_name,product_price) values('m_shirts','베이직 링클프리 심플 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_pants','5color 코튼 밴딩 팬츠',39900);
insert into product(product_code,product_name,product_price) values('m_pants','하우스 텐션 슬랙스 (구김방지/히든밴딩)',39900);
insert into product(product_code,product_name,product_price) values('m_pants','페브릭 트레이닝 팬츠',44900);
insert into product(product_code,product_name,product_price) values('m_pants','핀턱 울 와이드 슬랙스',44900);
insert into product(product_code,product_name,product_price) values('m_pants','원턱 레귤러 기모 슬랙스',44900);
insert into product(product_code,product_name,product_price) values('m_pants','AW 세미 스판 밴딩 슬랙스',34900);
insert into product(product_code,product_name,product_price) values('m_pants','로렌 테이퍼드 코튼팬츠',39900);
insert into product(product_code,product_name,product_price) values('m_pants','데일리 모던 울 슬랙스',39900);
insert into product(product_code,product_name,product_price) values('m_pants','모던 와이드 슬랙스',47900);
insert into product(product_code,product_name,product_price) values('m_pants','데일리 스탠다드 데님',49900);
insert into product(product_code,product_name,product_price) values('m_pants','3color 크림 네츄럴 데님',49900);
insert into product(product_code,product_name,product_price) values('m_pants','유니 코튼 치노 팬츠',32900);
insert into product(product_code,product_name,product_price) values('m_pants','모나크 슬랙스',47900);
insert into product(product_code,product_name,product_price) values('m_pants','로트 투턱 와이드 슬랙스',29900);
insert into product(product_code,product_name,product_price) values('m_pants','오르 스판 슬랙스',34900);
insert into product(product_code,product_name,product_price) values('m_pants','유즈 세미와이드 슬랙스',37900);
insert into product(product_code,product_name,product_price) values('m_pants','로밍 원턱 스웻팬츠',44900);
insert into product(product_code,product_name,product_price) values('m_pants','프로그 와이드 슬랙스',49900);
insert into product(product_code,product_name,product_price) values('m_pants','스티즈 와이드 슬랙스',34900);
insert into product(product_code,product_name,product_price) values('m_pants','2color 클래식 체크 슬랙스',45900);
insert into product(product_code,product_name,product_price) values('m_pants','로먼 트임 데님팬츠 - BLACK',52900);
insert into product(product_code,product_name,product_price) values('m_pants','루시 매직 밴딩 슬랙스',34900);
insert into product(product_code,product_name,product_price) values('m_pants','밀리 와이드 데님팬츠',34900);
insert into product(product_code,product_name,product_price) values('m_pants','르엔느 와이드 직기 슬랙스',39900);
insert into product(product_code,product_name,product_price) values('m_pants','하프 오버 핀턱 팬츠',49900);
insert into product(product_code,product_name,product_price) values('m_pants','멜튼 코듀로이 밴딩팬츠',24900);
insert into product(product_code,product_name,product_price) values('m_pants','시크릿 밴딩 슬랙스',34900);
insert into product(product_code,product_name,product_price) values('m_pants','리드 옆트임 와이드 슬랙스',29900);
insert into product(product_code,product_name,product_price) values('m_pants','데미지 스트레이트 제로 데님 by showpin (커팅타입)',49900);
insert into product(product_code,product_name,product_price) values('m_pants','노르딕 코튼 팬츠',37900);
insert into product(product_code,product_name,product_price) values('m_pants','웨스턴 밴딩 코튼팬츠',34900);
insert into product(product_code,product_name,product_price) values('m_pants','솔리드 세미와이드 슬랙스',32900);
insert into product(product_code,product_name,product_price) values('m_pants','모스트 베이직 슬랙스',29900);
insert into product(product_code,product_name,product_price) values('m_outer','필슨 오버 블레이저',94900);
insert into product(product_code,product_name,product_price) values('m_outer','마일드 후드 점퍼',39900);
insert into product(product_code,product_name,product_price) values('m_outer','오스카 피쉬테일 야상패딩',99000);
insert into product(product_code,product_name,product_price) values('m_outer','베이직 심플 항공 점퍼',44900);
insert into product(product_code,product_name,product_price) values('m_outer','켈튼 니트 카라 자켓',59900);
insert into product(product_code,product_name,product_price) values('m_outer','로디 오버핏 가디건 (~3XL)',29900);
insert into product(product_code,product_name,product_price) values('m_outer','에르 울 더블 코트',89900);
insert into product(product_code,product_name,product_price) values('m_outer','에르 울 싱글 코트',89900);
insert into product(product_code,product_name,product_price) values('m_outer','릴렉스드 울 캐시 자켓',89900);
insert into product(product_code,product_name,product_price) values('m_outer','솔리드 울 캐시미어 오버 싱글 코트',109000);
insert into product(product_code,product_name,product_price) values('m_outer','8color 클래식 세미오버 자켓',79900);
insert into product(product_code,product_name,product_price) values('m_outer','투포켓 핫찌 라운드 집업',59900);
insert into product(product_code,product_name,product_price) values('m_outer','AW 솔리드 싱글 자켓',79000);
insert into product(product_code,product_name,product_price) values('m_outer','프렌 니트 하프집업',39900);
insert into product(product_code,product_name,product_price) values('m_outer','유니 벌룬 자켓',57900);
insert into product(product_code,product_name,product_price) values('m_outer','프렌 니트 풀집업',39900);
insert into product(product_code,product_name,product_price) values('m_outer','14color 베이직 캐주얼 가디건',39900);
insert into product(product_code,product_name,product_price) values('m_outer','AW 울 캐시미어 싱글/더블 코트',99000);
insert into product(product_code,product_name,product_price) values('m_outer','데일리 오버 트렌치 코트',72900);
insert into product(product_code,product_name,product_price) values('m_outer','브로인 3버튼 싱글 코트',69900);
insert into product(product_code,product_name,product_price) values('m_knit','소프트 버튼넥 캐시 니트',39900);
insert into product(product_code,product_name,product_price) values('m_knit','레나 심플 usa 니트',39900);
insert into product(product_code,product_name,product_price) values('m_knit','2 Type 터틀넥 라운드 니트 - 2차 리오더',24900);
insert into product(product_code,product_name,product_price) values('m_knit','오슬로 버튼 터틀넥 니트',39900);
insert into product(product_code,product_name,product_price) values('m_knit','멀티 케이블 브이넥 니트',39900);
insert into product(product_code,product_name,product_price) values('m_knit','캐시 베이직 라운드니트',44900);
insert into product(product_code,product_name,product_price) values('m_knit','베르니 하프집업 니트',44900);
insert into product(product_code,product_name,product_price) values('m_knit','모어 라운드넥 니트',44900);
insert into product(product_code,product_name,product_price) values('m_knit','클로이 루즈 트임 니트',29900);
insert into product(product_code,product_name,product_price) values('m_knit','심플리 라운드 니트',34900);
insert into product(product_code,product_name,product_price) values('m_knit','캐시 케이블 라운드 니트',44900);
insert into product(product_code,product_name,product_price) values('m_knit','비엔느 V넥 니트',34900);
insert into product(product_code,product_name,product_price) values('m_knit','알렌 오픈넥 니트',34900);
insert into product(product_code,product_name,product_price) values('m_knit','웨이 골지 캐시 폴라니트',44900);
insert into product(product_code,product_name,product_price) values('m_knit','솔리드 와플 니트 - 2차 리오더',24900);
insert into product(product_code,product_name,product_price) values('m_knit','소프트 모헤어 카라니트',57900);
insert into product(product_code,product_name,product_price) values('m_knit','소프트 하프폴라 니트티',19900);
insert into product(product_code,product_name,product_price) values('m_knit','레이 스탠다드 라운드 니트',29900);
insert into product(product_code,product_name,product_price) values('m_knit','스탠다드 안티필링 니트티 (보풀방지)',32900);
insert into product(product_code,product_name,product_price) values('m_knit','레이 스탠다드 하프넥 니트',29900);
insert into product(product_code,product_name,product_price) values('m_knit','와플 심플리 니트',27900);
insert into product(product_code,product_name,product_price) values('w_bottom','러넬 와이드 린넨 슬랙스',29900);
insert into product(product_code,product_name,product_price) values('w_bottom','2 Type 벨키 하이웨스트 슬랙스 (~4XL)',29900);
insert into product(product_code,product_name,product_price) values('w_bottom','레프너 스트레이트핏 데님 (히든밴딩)',27900);
insert into product(product_code,product_name,product_price) values('w_bottom','레미 A라인 스커트',19900);
insert into product(product_code,product_name,product_price) values('w_bottom','리엔 세미와이드 코튼팬츠',21900);
insert into product(product_code,product_name,product_price) values('w_bottom','베럴 스판 크롭 부츠컷',32000);
insert into product(product_code,product_name,product_price) values('w_bottom','라이프 크롭 슬림 팬츠',29900);
insert into product(product_code,product_name,product_price) values('w_bottom','페넷 투버튼 하이웨스트 부츠컷',27900);
insert into product(product_code,product_name,product_price) values('w_bottom','레프너 슬림핏 데님 (히든밴딩)',27900);
insert into product(product_code,product_name,product_price) values('w_bottom','제노브 원턱 와이드 슬랙스',27900);
insert into product(product_code,product_name,product_price) values('w_bottom','뮤타 뒷밴딩 와이드 슬랙스',29900);
insert into product(product_code,product_name,product_price) values('w_knit','멜로우 라운드 반팔 니트',19000);
insert into product(product_code,product_name,product_price) values('w_knit','멜로우 브이넥 반팔 니트',19900);
insert into product(product_code,product_name,product_price) values('w_knit','로비아 골지 가디건',24900);
insert into product(product_code,product_name,product_price) values('w_outer','베네 카라 배색 가디건',34900);
insert into product(product_code,product_name,product_price) values('w_outer','이브 카라 니트집업',37900);
insert into product(product_code,product_name,product_price) values('w_outer','레티 스트라이프 라운드 가디건',39900);
insert into product(product_code,product_name,product_price) values('w_outer','스퀘어 브이넥 골지 가디건',21900);
insert into product(product_code,product_name,product_price) values('w_outer','로비아 골지 가디건',24900);
insert into product(product_code,product_name,product_price) values('w_shirts','팔레드 뒷 슬릿 블라우스',21900);
insert into product(product_code,product_name,product_price) values('w_shirts','팔레드 오버핏 롱 블라우스',21900);
insert into product(product_code,product_name,product_price) values('w_shirts','시아 셔링 링클프리 블라우스',24900);
insert into product(product_code,product_name,product_price) values('m_suit','AW 솔리드 싱글 수트 (모던타입/히든밴딩)',99000);
insert into product(product_code,product_name,product_price) values('m_suit','필슨 오버 싱글 수트',129000);
insert into product(product_code,product_name,product_price) values('m_suit','릴렉스드 울 캐시 수트',119000);
insert into product(product_code,product_name,product_price) values('m_suit','AW 솔리드 싱글 수트 (히든밴딩)',99000);
insert into product(product_code,product_name,product_price) values('m_suit','2color 클래식 체크 수트',129000);
insert into product(product_code,product_name,product_price) values('m_suit','AW 세미 오버 스판 수트',109000);
insert into product(product_code,product_name,product_price) values('m_suit','브래스 스판 싱글 수트',99000);
insert into product(product_code,product_name,product_price) values('m_suit','릴렉스 AW 솔리드 수트 (스트레치원단/히든밴딩)',109000);
insert into product(product_code,product_name,product_price) values('m_suit','펜드 투버튼 수트',109000);
insert into product(product_code,product_name,product_price) values('m_suit','AW 솔리드 싱글 수트 (심플타입/히든밴딩)',99000);
insert into product(product_code,product_name,product_price) values('m_suit','루시 싱글 수트',99000);
insert into product(product_code,product_name,product_price) values('m_suit','오르 스판 싱글 수트',109000);
insert into product(product_code,product_name,product_price) values('w_top','피네츠 골지 라운드 반팔티',12900);
insert into product(product_code,product_name,product_price) values('w_top','데이지 하프넥 반팔티',11900);
insert into product(product_code,product_name,product_price) values('w_top','테니 라운드 헤리티',14900);
insert into product(product_code,product_name,product_price) values('w_top','리엘 골지 라운드 긴팔티',12900);
insert into product(product_code,product_name,product_price) values('w_top','렌느 골지 U넥 긴팔티',12900);
insert into product(product_code,product_name,product_price) values('w_top','스프링 스트라이프 긴팔티',12900);
insert into product(product_code,product_name,product_price) values('w_top','미유 슬림 롱슬리브티',16900);
insert into product(product_code,product_name,product_price) values('w_top','베니 소프트 골지 폴라티',17900);



insert into product_d_img values('m_knit_1_d_1.jpg',116);
insert into product_d_img values('m_knit_10_d_1.jpg',125);
insert into product_d_img values('m_knit_11_d_1.jpg',126);
insert into product_d_img values('m_knit_12_d_1.jpg',127);
insert into product_d_img values('m_knit_13_d_1.jpg',128);
insert into product_d_img values('m_knit_14_d_1.jpg',129);
insert into product_d_img values('m_knit_15_d_1.jpg',130);
insert into product_d_img values('m_knit_16_d_1.jpg',131);
insert into product_d_img values('m_knit_17_d_1.jpg',132);
insert into product_d_img values('m_knit_18_d_1.jpg',133);
insert into product_d_img values('m_knit_19_d_1.jpg',134);
insert into product_d_img values('m_knit_2_d_1.jpg',117);
insert into product_d_img values('m_knit_20_d_1.jpg',135);
insert into product_d_img values('m_knit_21_d_1.jpg',136);
insert into product_d_img values('m_knit_3_d_1.jpg',118);
insert into product_d_img values('m_knit_4_d_1.jpg',119);
insert into product_d_img values('m_knit_5_d_1.jpg',120);
insert into product_d_img values('m_knit_6_d_1.jpg',121);
insert into product_d_img values('m_knit_7_d_1.jpg',122);
insert into product_d_img values('m_knit_8_d_1.jpg',123);
insert into product_d_img values('m_knit_9_d_1.jpg',124);
insert into product_d_img values('m_outer_1_d_1.jpg',96);
insert into product_d_img values('m_outer_10_d_1.jpg',105);
insert into product_d_img values('m_outer_11_d_1.jpg',106);
insert into product_d_img values('m_outer_12_d_1.jpg',107);
insert into product_d_img values('m_outer_13_d_1.jpg',108);
insert into product_d_img values('m_outer_14_d_1.jpg',109);
insert into product_d_img values('m_outer_15_d_1.jpg',110);
insert into product_d_img values('m_outer_16_d_1.jpg',111);
insert into product_d_img values('m_outer_17_d_1.jpg',112);
insert into product_d_img values('m_outer_18_d_1.jpg',113);
insert into product_d_img values('m_outer_19_d_1.jpg',114);
insert into product_d_img values('m_outer_2_d_1.jpg',97);
insert into product_d_img values('m_outer_20_d_1.jpg',115);
insert into product_d_img values('m_outer_3_d_1.jpg',98);
insert into product_d_img values('m_outer_4_d_1.jpg',99);
insert into product_d_img values('m_outer_5_d_1.jpg',100);
insert into product_d_img values('m_outer_6_d_1.jpg',101);
insert into product_d_img values('m_outer_7_d_1.jpg',102);
insert into product_d_img values('m_outer_8_d_1.jpg',103);
insert into product_d_img values('m_outer_9_d_1.jpg',104);
insert into product_d_img values('m_pants_1_d_1.jpg',63);
insert into product_d_img values('m_pants_10_d_1.jpg',72);
insert into product_d_img values('m_pants_11_d_1.jpg',73);
insert into product_d_img values('m_pants_12_d_1.jpg',74);
insert into product_d_img values('m_pants_13_d_1.jpg',75);
insert into product_d_img values('m_pants_14_d_1.jpg',76);
insert into product_d_img values('m_pants_15_d_1.jpg',77);
insert into product_d_img values('m_pants_16_d_1.jpg',78);
insert into product_d_img values('m_pants_17_d_1.jpg',79);
insert into product_d_img values('m_pants_18_d_1.jpg',80);
insert into product_d_img values('m_pants_19_d_1.jpg',81);
insert into product_d_img values('m_pants_2_d_1.jpg',64);
insert into product_d_img values('m_pants_20_d_1.jpg',82);
insert into product_d_img values('m_pants_21_d_1.jpg',83);
insert into product_d_img values('m_pants_22_d_1.jpg',84);
insert into product_d_img values('m_pants_23_d_1.jpg',85);
insert into product_d_img values('m_pants_24_d_1.jpg',86);
insert into product_d_img values('m_pants_25_d_1.jpg',87);
insert into product_d_img values('m_pants_26_d_1.jpg',88);
insert into product_d_img values('m_pants_27_d_1.jpg',89);
insert into product_d_img values('m_pants_28_d_1.jpg',90);
insert into product_d_img values('m_pants_29_d_1.jpg',91);
insert into product_d_img values('m_pants_3_d_1.jpg',65);
insert into product_d_img values('m_pants_30_d_1.jpg',92);
insert into product_d_img values('m_pants_31_d_1.jpg',93);
insert into product_d_img values('m_pants_32_d_1.jpg',94);
insert into product_d_img values('m_pants_33_d_1.jpg',95);
insert into product_d_img values('m_pants_4_d_1.jpg',66);
insert into product_d_img values('m_pants_5_d_1.jpg',67);
insert into product_d_img values('m_pants_6_d_1.jpg',68);
insert into product_d_img values('m_pants_7_d_1.jpg',69);
insert into product_d_img values('m_pants_8_d_1.jpg',70);
insert into product_d_img values('m_pants_9_d_1.jpg',71);
insert into product_d_img values('m_shirts_1_d_1.jpg',59);
insert into product_d_img values('m_shirts_10_d_1.jpg',44);
insert into product_d_img values('m_shirts_11_d_1.jpg',53);
insert into product_d_img values('m_shirts_12_d_1.jpg',54);
insert into product_d_img values('m_shirts_13_d_1.jpg',55);
insert into product_d_img values('m_shirts_14_d_1.jpg',56);
insert into product_d_img values('m_shirts_15_d_1.jpg',57);
insert into product_d_img values('m_shirts_16_d_1.jpg',58);
insert into product_d_img values('m_shirts_17_d_1.jpg',60);
insert into product_d_img values('m_shirts_18_d_1.jpg',61);
insert into product_d_img values('m_shirts_19_d_1.jpg',62);
insert into product_d_img values('m_shirts_2_d_1.jpg',45);
insert into product_d_img values('m_shirts_3_d_1.jpg',46);
insert into product_d_img values('m_shirts_4_d_1.jpg',48);
insert into product_d_img values('m_shirts_5_d_1.jpg',49);
insert into product_d_img values('m_shirts_6_d_1.jpg',50);
insert into product_d_img values('m_shirts_7_d_1.jpg',51);
insert into product_d_img values('m_shirts_8_d_1.jpg',52);
insert into product_d_img values('m_shirts_9_d_1.jpg',47);
insert into product_d_img values('m_shoes_1_d_1.jpg',24);
insert into product_d_img values('m_shoes_10_d_1.jpg',33);
insert into product_d_img values('m_shoes_11_d_1.jpg',34);
insert into product_d_img values('m_shoes_12_d_1.jpg',35);
insert into product_d_img values('m_shoes_13_d_1.jpg',36);
insert into product_d_img values('m_shoes_14_d_1.jpg',37);
insert into product_d_img values('m_shoes_15_d_1.jpg',38);
insert into product_d_img values('m_shoes_16_d_1.jpg',39);
insert into product_d_img values('m_shoes_17_d_1.jpg',40);
insert into product_d_img values('m_shoes_18_d_1.jpg',41);
insert into product_d_img values('m_shoes_19_d_1.jpg',42);
insert into product_d_img values('m_shoes_2_d_1.jpg',25);
insert into product_d_img values('m_shoes_20_d_1.jpg',43);
insert into product_d_img values('m_shoes_3_d_1.jpg',26);
insert into product_d_img values('m_shoes_4_d_1.jpg',27);
insert into product_d_img values('m_shoes_5_d_1.jpg',28);
insert into product_d_img values('m_shoes_6_d_1.jpg',29);
insert into product_d_img values('m_shoes_7_d_1.jpg',30);
insert into product_d_img values('m_shoes_8_d_1.jpg',31);
insert into product_d_img values('m_shoes_9_d_1.jpg',32);
insert into product_d_img values('m_suit_1_d_1.jpg',159);
insert into product_d_img values('m_suit_10_d_1.jpg',160);
insert into product_d_img values('m_suit_11_d_1.jpg',161);
insert into product_d_img values('m_suit_12_d_1.jpg',162);
insert into product_d_img values('m_suit_2_d_1.jpg',163);
insert into product_d_img values('m_suit_3_d_1.jpg',164);
insert into product_d_img values('m_suit_4_d_1.jpg',165);
insert into product_d_img values('m_suit_5_d_1.jpg',166);
insert into product_d_img values('m_suit_6_d_1.jpg',167);
insert into product_d_img values('m_suit_7_d_1.jpg',168);
insert into product_d_img values('m_suit_8_d_1.jpg',169);
insert into product_d_img values('m_suit_9_d_1.jpg',170);
insert into product_d_img values('m_top_1_d_1.jpg',1);
insert into product_d_img values('m_top_10_d_1.jpg',10);
insert into product_d_img values('m_top_11_d_1.jpg',11);
insert into product_d_img values('m_top_12_d_1.jpg',12);
insert into product_d_img values('m_top_13_d_1.jpg',13);
insert into product_d_img values('m_top_14_d_1.jpg',14);
insert into product_d_img values('m_top_15_d_1.jpg',15);
insert into product_d_img values('m_top_16_d_1.jpg',16);
insert into product_d_img values('m_top_17_d_1.jpg',17);
insert into product_d_img values('m_top_18_d_1.jpg',18);
insert into product_d_img values('m_top_19_d_1.jpg',19);
insert into product_d_img values('m_top_2_d_1.jpg',2);
insert into product_d_img values('m_top_20_d_1.jpg',20);
insert into product_d_img values('m_top_21_d_1.jpg',21);
insert into product_d_img values('m_top_22_d_1.jpg',22);
insert into product_d_img values('m_top_23_d_1.jpg',23);
insert into product_d_img values('m_top_3_d_1.jpg',3);
insert into product_d_img values('m_top_4_d_1.jpg',4);
insert into product_d_img values('m_top_5_d_1.jpg',5);
insert into product_d_img values('m_top_6_d_1.jpg',6);
insert into product_d_img values('m_top_7_d_1.jpg',7);
insert into product_d_img values('m_top_8_d_1.jpg',8);
insert into product_d_img values('m_top_9_d_1.jpg',9);
insert into product_d_img values('w_bottom_1_d_1.jpg',137);
insert into product_d_img values('w_bottom_10_d_1.jpg',138);
insert into product_d_img values('w_bottom_11_d_1.jpg',139);
insert into product_d_img values('w_bottom_2_d_1.jpg',140);
insert into product_d_img values('w_bottom_3_d_1.jpg',141);
insert into product_d_img values('w_bottom_4_d_1.jpg',142);
insert into product_d_img values('w_bottom_5_d_1.jpg',143);
insert into product_d_img values('w_bottom_6_d_1.jpg',144);
insert into product_d_img values('w_bottom_7_d_1.jpg',145);
insert into product_d_img values('w_bottom_8_d_1.jpg',146);
insert into product_d_img values('w_bottom_9_d_1.jpg',147);
insert into product_d_img values('w_knit_1_d_1.gif',148);
insert into product_d_img values('w_knit_2_d_1.gif',149);
insert into product_d_img values('w_knit_3_d_1.jpg',150);
insert into product_d_img values('w_outer_1_d_1.jpg',151);
insert into product_d_img values('w_outer_2_d_1.jpg',152);
insert into product_d_img values('w_outer_3_d_1.jpg',153);
insert into product_d_img values('w_outer_4_d_1.jpg',154);
insert into product_d_img values('w_outer_5_d_1.jpg',155);
insert into product_d_img values('w_shirts_1_d_1.jpg',156);
insert into product_d_img values('w_shirts_2_d_1.jpg',157);
insert into product_d_img values('w_shirts_3_d_1.jpg',158);
insert into product_d_img values('w_top_1_d_1.jpg',171);
insert into product_d_img values('w_top_2_d_1.jpg',172);
insert into product_d_img values('w_top_3_d_1.jpg',173);
insert into product_d_img values('w_top_4_d_1.jpg',174);
insert into product_d_img values('w_top_5_d_1.jpg',175);
insert into product_d_img values('w_top_6_d_1.jpg',176);
insert into product_d_img values('w_top_7_d_1.jpg',177);
insert into product_d_img values('w_top_8_d_1.jpg',178);
insert into product_t_img values('m_knit_1_t_1.jpg',116);
insert into product_t_img values('m_knit_10_t_1.jpg',125);
insert into product_t_img values('m_knit_11_t_1.jpg',126);
insert into product_t_img values('m_knit_12_t_1.jpg',127);
insert into product_t_img values('m_knit_13_t_1.jpg',128);
insert into product_t_img values('m_knit_14_t_1.jpg',129);
insert into product_t_img values('m_knit_15_t_1.jpg',130);
insert into product_t_img values('m_knit_16_t_1.jpg',131);
insert into product_t_img values('m_knit_17_t_1.jpg',132);
insert into product_t_img values('m_knit_18_t_1.jpg',133);
insert into product_t_img values('m_knit_19_t_1.jpg',134);
insert into product_t_img values('m_knit_2_t_1.jpg',117);
insert into product_t_img values('m_knit_20_t_1.jpg',135);
insert into product_t_img values('m_knit_21_t_1.jpg',136);
insert into product_t_img values('m_knit_3_t_1.jpg',118);
insert into product_t_img values('m_knit_4_t_1.jpg',119);
insert into product_t_img values('m_knit_5_t_1.jpg',120);
insert into product_t_img values('m_knit_6_t_1.jpg',121);
insert into product_t_img values('m_knit_7_t_1.jpg',122);
insert into product_t_img values('m_knit_8_t_1.jpg',123);
insert into product_t_img values('m_knit_9_t_1.jpg',124);
insert into product_t_img values('m_outer_1_t_1.jpg',96);
insert into product_t_img values('m_outer_10_t_1.jpg',105);
insert into product_t_img values('m_outer_11_t_1.jpg',106);
insert into product_t_img values('m_outer_12_t_1.jpg',107);
insert into product_t_img values('m_outer_13_t_1.jpg',108);
insert into product_t_img values('m_outer_14_t_1.jpg',109);
insert into product_t_img values('m_outer_15_t_1.jpg',110);
insert into product_t_img values('m_outer_16_t_1.jpg',111);
insert into product_t_img values('m_outer_17_t_1.jpg',112);
insert into product_t_img values('m_outer_18_t_1.jpg',113);
insert into product_t_img values('m_outer_19_t_1.jpg',114);
insert into product_t_img values('m_outer_2_t_1.jpg',97);
insert into product_t_img values('m_outer_20_t_1.jpg',115);
insert into product_t_img values('m_outer_3_t_1.jpg',98);
insert into product_t_img values('m_outer_4_t_1.jpg',99);
insert into product_t_img values('m_outer_5_t_1.jpg',100);
insert into product_t_img values('m_outer_6_t_1.jpg',101);
insert into product_t_img values('m_outer_7_t_1.jpg',102);
insert into product_t_img values('m_outer_8_t_1.jpg',103);
insert into product_t_img values('m_outer_9_t_1.jpg',104);
insert into product_t_img values('m_pants_1_t_1.jpg',63);
insert into product_t_img values('m_pants_10_t_1.jpg',72);
insert into product_t_img values('m_pants_11_t_1.jpg',73);
insert into product_t_img values('m_pants_12_t_1.jpg',74);
insert into product_t_img values('m_pants_13_t_1.jpg',75);
insert into product_t_img values('m_pants_14_t_1.jpg',76);
insert into product_t_img values('m_pants_15_t_1.jpg',77);
insert into product_t_img values('m_pants_16_t_1.jpg',78);
insert into product_t_img values('m_pants_17_t_1.jpg',79);
insert into product_t_img values('m_pants_18_t_1.jpg',80);
insert into product_t_img values('m_pants_19_t_1.jpg',81);
insert into product_t_img values('m_pants_2_t_1.jpg',64);
insert into product_t_img values('m_pants_20_t_1.jpg',82);
insert into product_t_img values('m_pants_21_t_1.jpg',83);
insert into product_t_img values('m_pants_22_t_1.jpg',84);
insert into product_t_img values('m_pants_23_t_1.jpg',85);
insert into product_t_img values('m_pants_24_t_1.jpg',86);
insert into product_t_img values('m_pants_25_t_1.jpg',87);
insert into product_t_img values('m_pants_26_t_1.jpg',88);
insert into product_t_img values('m_pants_27_t_1.jpg',89);
insert into product_t_img values('m_pants_28_t_1.jpg',90);
insert into product_t_img values('m_pants_29_t_1.jpg',91);
insert into product_t_img values('m_pants_3_t_1.jpg',65);
insert into product_t_img values('m_pants_30_t_1.jpg',92);
insert into product_t_img values('m_pants_31_t_1.jpg',93);
insert into product_t_img values('m_pants_32_t_1.jpg',94);
insert into product_t_img values('m_pants_33_t_1.jpg',95);
insert into product_t_img values('m_pants_4_t_1.jpg',66);
insert into product_t_img values('m_pants_5_t_1.jpg',67);
insert into product_t_img values('m_pants_6_t_1.jpg',68);
insert into product_t_img values('m_pants_7_t_1.jpg',69);
insert into product_t_img values('m_pants_8_t_1.jpg',70);
insert into product_t_img values('m_pants_9_t_1.jpg',71);
insert into product_t_img values('m_shirts_1_t_1.jpg',59);
insert into product_t_img values('m_shirts_10_t_1.jpg',44);
insert into product_t_img values('m_shirts_11_t_1.jpg',53);
insert into product_t_img values('m_shirts_12_t_1.jpg',54);
insert into product_t_img values('m_shirts_13_t_1.jpg',55);
insert into product_t_img values('m_shirts_14_t_1.jpg',56);
insert into product_t_img values('m_shirts_15_t_1.jpg',57);
insert into product_t_img values('m_shirts_16_t_1.jpg',58);
insert into product_t_img values('m_shirts_17_t_1.jpg',60);
insert into product_t_img values('m_shirts_18_t_1.jpg',61);
insert into product_t_img values('m_shirts_19_t_1.jpg',62);
insert into product_t_img values('m_shirts_2_t_1.jpg',45);
insert into product_t_img values('m_shirts_3_t_1.jpg',46);
insert into product_t_img values('m_shirts_4_t_1.jpg',48);
insert into product_t_img values('m_shirts_5_t_1.jpg',49);
insert into product_t_img values('m_shirts_6_t_1.jpg',50);
insert into product_t_img values('m_shirts_7_t_1.jpg',51);
insert into product_t_img values('m_shirts_8_t_1.jpg',52);
insert into product_t_img values('m_shirts_9_t_1.jpg',47);
insert into product_t_img values('m_shoes_1_t_1.jpg',24);
insert into product_t_img values('m_shoes_10_t_1.jpg',33);
insert into product_t_img values('m_shoes_11_t_1.jpg',34);
insert into product_t_img values('m_shoes_12_t_1.jpg',35);
insert into product_t_img values('m_shoes_13_t_1.jpg',36);
insert into product_t_img values('m_shoes_14_t_1.jpg',37);
insert into product_t_img values('m_shoes_15_t_1.jpg',38);
insert into product_t_img values('m_shoes_16_t_1.jpg',39);
insert into product_t_img values('m_shoes_17_t_1.jpg',40);
insert into product_t_img values('m_shoes_18_t_1.jpg',41);
insert into product_t_img values('m_shoes_19_t_1.jpg',42);
insert into product_t_img values('m_shoes_2_t_1.jpg',25);
insert into product_t_img values('m_shoes_20_t_1.jpg',43);
insert into product_t_img values('m_shoes_3_t_1.jpg',26);
insert into product_t_img values('m_shoes_4_t_1.jpg',27);
insert into product_t_img values('m_shoes_5_t_1.jpg',28);
insert into product_t_img values('m_shoes_6_t_1.jpg',29);
insert into product_t_img values('m_shoes_7_t_1.jpg',30);
insert into product_t_img values('m_shoes_8_t_1.jpg',31);
insert into product_t_img values('m_shoes_9_t_1.jpg',32);
insert into product_t_img values('m_suit_1_t_1.jpg',159);
insert into product_t_img values('m_suit_10_t_1.jpg',160);
insert into product_t_img values('m_suit_11_t_1.jpg',161);
insert into product_t_img values('m_suit_12_t_1.jpg',162);
insert into product_t_img values('m_suit_2_t_1.jpg',163);
insert into product_t_img values('m_suit_3_t_1.jpg',164);
insert into product_t_img values('m_suit_4_t_1.jpg',165);
insert into product_t_img values('m_suit_5_t_1.jpg',166);
insert into product_t_img values('m_suit_6_t_1.jpg',167);
insert into product_t_img values('m_suit_7_t_1.jpg',168);
insert into product_t_img values('m_suit_8_t_1.jpg',169);
insert into product_t_img values('m_suit_9_t_1.jpg',170);
insert into product_t_img values('m_top_1_t_1.jpg',1);
insert into product_t_img values('m_top_10_t_1.jpg',10);
insert into product_t_img values('m_top_11_t_1.jpg',11);
insert into product_t_img values('m_top_12_t_1.jpg',12);
insert into product_t_img values('m_top_13_t_1.jpg',13);
insert into product_t_img values('m_top_14_t_1.jpg',14);
insert into product_t_img values('m_top_15_t_1.jpg',15);
insert into product_t_img values('m_top_16_t_1.jpg',16);
insert into product_t_img values('m_top_17_t_1.jpg',17);
insert into product_t_img values('m_top_18_t_1.jpg',18);
insert into product_t_img values('m_top_19_t_1.jpg',19);
insert into product_t_img values('m_top_2_t_1.jpg',2);
insert into product_t_img values('m_top_20_t_1.jpg',20);
insert into product_t_img values('m_top_21_t_1.jpg',21);
insert into product_t_img values('m_top_22_t_1.jpg',22);
insert into product_t_img values('m_top_23_t_1.jpg',23);
insert into product_t_img values('m_top_3_t_1.jpg',3);
insert into product_t_img values('m_top_4_t_1.jpg',4);
insert into product_t_img values('m_top_5_t_1.jpg',5);
insert into product_t_img values('m_top_6_t_1.jpg',6);
insert into product_t_img values('m_top_7_t_1.jpg',7);
insert into product_t_img values('m_top_8_t_1.jpg',8);
insert into product_t_img values('m_top_9_t_1.jpg',9);
insert into product_t_img values('w_bottom_1_t_1.jpg',137);
insert into product_t_img values('w_bottom_10_t_1.jpg',138);
insert into product_t_img values('w_bottom_11_t_1.jpg',139);
insert into product_t_img values('w_bottom_2_t_1.jpg',140);
insert into product_t_img values('w_bottom_3_t_1.jpg',141);
insert into product_t_img values('w_bottom_4_t_1.jpg',142);
insert into product_t_img values('w_bottom_5_t_1.jpg',143);
insert into product_t_img values('w_bottom_6_t_1.jpg',144);
insert into product_t_img values('w_bottom_7_t_1.jpg',145);
insert into product_t_img values('w_bottom_8_t_1.jpg',146);
insert into product_t_img values('w_bottom_9_t_1.jpg',147);
insert into product_t_img values('w_knit_1_t_1.jpg',148);
insert into product_t_img values('w_knit_2_t_1.jpg',149);
insert into product_t_img values('w_knit_3_t_1.jpg',150);
insert into product_t_img values('w_outer_1_t_1.jpg',151);
insert into product_t_img values('w_outer_2_t_1.jpg',152);
insert into product_t_img values('w_outer_3_t_1.jpg',153);
insert into product_t_img values('w_outer_4_t_1.jpg',154);
insert into product_t_img values('w_outer_5_t_1.jpg',155);
insert into product_t_img values('w_shirts_1_t_1.jpg',156);
insert into product_t_img values('w_shirts_2_t_1.jpg',157);
insert into product_t_img values('w_shirts_3_t_1.jpg',158);
insert into product_t_img values('w_top_1_t_1.jpg',171);
insert into product_t_img values('w_top_2_t_1.jpg',172);
insert into product_t_img values('w_top_3_t_1.jpg',173);
insert into product_t_img values('w_top_4_t_1.jpg',174);
insert into product_t_img values('w_top_5_t_1.jpg',175);
insert into product_t_img values('w_top_6_t_1.jpg',176);
insert into product_t_img values('w_top_7_t_1.jpg',177);
insert into product_t_img values('w_top_8_t_1.jpg',178);
------------------------------------------------------------------------

-- product_opt 옵션 더미

insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','블랙',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','소라',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','아이보리',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','블랙',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','소라',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','아이보리',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','블랙',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','소라',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','아이보리',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','블랙',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','소라',0);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','아이보리',0);


insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-13','fwxLHU60','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-11','CLeLwR82','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-15','rlReFg93','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-31','wzBsVc87','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-11','uWgSgq70','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-19','pYHZAb59','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-17','dYzsUd66','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-28','zPVaYB33','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-14','YGshpn97','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-02','dUteJB40','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-28','KgcCXs43','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-27','EOHmJC56','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-02','DMKnnD87','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-21','nZeBmC16','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-28','gpLvvj41','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-03-03','rHtSTI72','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-30','cvsxVu92','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-24','zDiPIW83','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-15','wwTnsG55','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-06','ScePkt52','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-28','WKwBhF62','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-15','OWrOwJ79','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-03','IHgEAW25','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-21','XcSZni35','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-15','NcSBdD29','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-15','SrsSEL34','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-13','glhJAQ84','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-14','sjKXlm25','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-20','WsjgUg67','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-02','dwPlKf63','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-06','IUBYjr86','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-08','xoFTmj2','12345','부광시 무학로 63번길 136', '301호','더미철현',16900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-21','gBOxjO33','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-03','oNaynr78','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-19','EzMXPG3','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-09','kLUpoq33','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-27','pZEoCz88','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-06','DrOGnG62','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-12','VTOjAT49','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-28','XJyCZZ61','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-27','fcrovy98','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-01','EItSUp52','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-25','eDpBpw6','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-20','wYhyME2','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-06','JKHESW34','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-09','ovRTAz44','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-21','CsoHlu97','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-16','vZCDbi97','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-17','VTEKpP32','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-03-02','trOGTA24','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-14','nKpupq15','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-26','hESTaB30','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-09','baNJKX15','12345','부광시 무학로 63번길 136', '301호','더미철현',101800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-13','kEAtoR65','12345','부광시 무학로 63번길 136', '301호','더미철현',101800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-22','wvDnWb84','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-18','WJueMS21','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-03','ogFdTo20','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-05','AzPciG70','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-01','WzUdCc60','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-19','mjRDRm11','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-05','lAujbT96','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-28','kztVZt81','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-21','xrdGjI5','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-15','mheOMS15','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-13','HMWkJe42','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-18','SVtlop17','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-23','dnRFMX55','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-04','ArzZSm10','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-15','MZvhZi26','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-08','zPGuUK34','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-23','qVNwgH95','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-12','oYAqbb1','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-10','jdAuXP97','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-01','XaCPzj99','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-30','HeNkgE81','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-02','tVXDXC30','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-08','LStNSZ90','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-03','ernGLF68','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-31','kdqLJe48','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-03','pkOCwk5','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-14','yoztKG24','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-19','HUTEIN97','12345','부광시 무학로 63번길 136', '301호','더미철현',57900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-09','hIbeRR98','12345','부광시 무학로 63번길 136', '301호','더미철현',57900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-30','qolOaA24','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-17','jqfSLv55','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-29','xifHmX30','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-05','iuXvxb50','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-04','JpyLGs26','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-03','onOzMc39','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-11','zoraHk37','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-26','FvLCIa13','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-08','YBKnXk66','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-20','prCLTb96','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-19','MtUdiA8','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-01','FvDhzH99','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-09','FwGLoS28','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-20','bOuIGy97','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-01','ixAXRA11','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-25','fwxLHU60','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-29','CLeLwR82','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-20','rlReFg93','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-15','wzBsVc87','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-29','uWgSgq70','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-07','pYHZAb59','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-15','dYzsUd66','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-07','zPVaYB33','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-09','YGshpn97','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-04','dUteJB40','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-12','KgcCXs43','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-14','EOHmJC56','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-09','DMKnnD87','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-23','nZeBmC16','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-09','gpLvvj41','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-22','rHtSTI72','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-16','cvsxVu92','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-17','zDiPIW83','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-11','wwTnsG55','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-10','ScePkt52','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-03-01','WKwBhF62','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-18','OWrOwJ79','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-15','IHgEAW25','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-23','XcSZni35','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-23','NcSBdD29','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-08','SrsSEL34','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-15','glhJAQ84','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-22','sjKXlm25','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-03','WsjgUg67','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-03','dwPlKf63','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-05','IUBYjr86','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-27','xoFTmj2','12345','부광시 무학로 63번길 136', '301호','더미철현',16900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-18','gBOxjO33','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-12','oNaynr78','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-03','EzMXPG3','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-22','kLUpoq33','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-18','pZEoCz88','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-10','DrOGnG62','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-17','VTOjAT49','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-14','XJyCZZ61','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-27','fcrovy98','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-26','EItSUp52','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-03','eDpBpw6','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-24','wYhyME2','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-31','JKHESW34','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-11','ovRTAz44','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-04','CsoHlu97','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-30','vZCDbi97','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-03','VTEKpP32','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-10','trOGTA24','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-29','nKpupq15','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-03-05','hESTaB30','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-17','baNJKX15','12345','부광시 무학로 63번길 136', '301호','더미철현',101800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-03','kEAtoR65','12345','부광시 무학로 63번길 136', '301호','더미철현',101800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-25','wvDnWb84','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-09','WJueMS21','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-08','ogFdTo20','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-18','AzPciG70','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-03','WzUdCc60','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-03-05','mjRDRm11','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-24','lAujbT96','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-27','kztVZt81','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-04','xrdGjI5','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-19','mheOMS15','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-20','HMWkJe42','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-17','SVtlop17','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-01','dnRFMX55','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-03','ArzZSm10','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-03','MZvhZi26','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-14','zPGuUK34','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-17','qVNwgH95','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-04','oYAqbb1','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-10','jdAuXP97','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-20','XaCPzj99','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-30','HeNkgE81','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-07','tVXDXC30','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-15','LStNSZ90','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-23','ernGLF68','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-01','kdqLJe48','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-03','pkOCwk5','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-02','yoztKG24','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-04','HUTEIN97','12345','부광시 무학로 63번길 136', '301호','더미철현',57900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-24','hIbeRR98','12345','부광시 무학로 63번길 136', '301호','더미철현',57900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-31','qolOaA24','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-08','jqfSLv55','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-13','xifHmX30','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-10','iuXvxb50','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-04','JpyLGs26','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-25','onOzMc39','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-12','zoraHk37','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-29','FvLCIa13','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-18','YBKnXk66','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-12','prCLTb96','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-20','MtUdiA8','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-26','FvDhzH99','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-11','FwGLoS28','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-18','bOuIGy97','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-29','ixAXRA11','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-17','fwxLHU60','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-15','CLeLwR82','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-02','rlReFg93','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-26','wzBsVc87','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-16','uWgSgq70','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-21','pYHZAb59','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-31','dYzsUd66','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-21','zPVaYB33','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-20','YGshpn97','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-24','dUteJB40','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-22','KgcCXs43','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-04','EOHmJC56','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-16','DMKnnD87','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-22','nZeBmC16','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-21','gpLvvj41','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-19','rHtSTI72','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-16','cvsxVu92','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-12','zDiPIW83','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-10','wwTnsG55','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-02','ScePkt52','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-05','WKwBhF62','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-20','OWrOwJ79','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-03','IHgEAW25','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-30','XcSZni35','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-16','NcSBdD29','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-29','SrsSEL34','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-12','glhJAQ84','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-25','sjKXlm25','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-08','WsjgUg67','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-06','dwPlKf63','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-11','IUBYjr86','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-09','xoFTmj2','12345','부광시 무학로 63번길 136', '301호','더미철현',16900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-20','gBOxjO33','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-21','oNaynr78','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-06','EzMXPG3','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-10','kLUpoq33','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-25','pZEoCz88','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-06','DrOGnG62','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-03-05','VTOjAT49','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-18','XJyCZZ61','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-03','fcrovy98','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-02','EItSUp52','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-28','eDpBpw6','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-06','wYhyME2','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-09','JKHESW34','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-16','ovRTAz44','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-14','CsoHlu97','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-07','vZCDbi97','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-04','VTEKpP32','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-12','trOGTA24','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-05','nKpupq15','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-22','hESTaB30','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-05','baNJKX15','12345','부광시 무학로 63번길 136', '301호','더미철현',101800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-26','kEAtoR65','12345','부광시 무학로 63번길 136', '301호','더미철현',101800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-08','wvDnWb84','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-29','WJueMS21','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-06','ogFdTo20','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-15','AzPciG70','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-30','WzUdCc60','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-09','mjRDRm11','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-21','lAujbT96','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-04','kztVZt81','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-05','xrdGjI5','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-17','mheOMS15','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-09','HMWkJe42','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-09','SVtlop17','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-17','dnRFMX55','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-12','ArzZSm10','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-13','MZvhZi26','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-02','zPGuUK34','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-27','qVNwgH95','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-07','oYAqbb1','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-18','jdAuXP97','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-11','XaCPzj99','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-19','HeNkgE81','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-17','tVXDXC30','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-21','LStNSZ90','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-03','ernGLF68','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-18','kdqLJe48','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-23','pkOCwk5','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-03','yoztKG24','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-13','HUTEIN97','12345','부광시 무학로 63번길 136', '301호','더미철현',57900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-08','hIbeRR98','12345','부광시 무학로 63번길 136', '301호','더미철현',57900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-05','qolOaA24','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-21','jqfSLv55','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-19','xifHmX30','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-05','iuXvxb50','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-28','JpyLGs26','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-29','onOzMc39','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-23','zoraHk37','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-09','FvLCIa13','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-16','YBKnXk66','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-16','prCLTb96','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-30','MtUdiA8','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-10','FvDhzH99','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-01','FwGLoS28','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-12','bOuIGy97','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-09','ixAXRA11','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-17','fwxLHU60','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-26','CLeLwR82','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-15','rlReFg93','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-24','wzBsVc87','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-13','uWgSgq70','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-23','pYHZAb59','12345','부광시 무학로 63번길 136', '301호','더미철현',49900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-19','dYzsUd66','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-26','zPVaYB33','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-11','YGshpn97','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-18','dUteJB40','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-22','KgcCXs43','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-28','EOHmJC56','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-21','DMKnnD87','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-04','nZeBmC16','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-07','gpLvvj41','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-06','rHtSTI72','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-28','cvsxVu92','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-10','zDiPIW83','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-03','wwTnsG55','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-17','ScePkt52','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-05','WKwBhF62','12345','부광시 무학로 63번길 136', '301호','더미철현',27900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-26','OWrOwJ79','12345','부광시 무학로 63번길 136', '301호','더미철현',19900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-24','IHgEAW25','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-24','XcSZni35','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-06','NcSBdD29','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-20','SrsSEL34','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-05','glhJAQ84','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-14','sjKXlm25','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-10','WsjgUg67','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-25','dwPlKf63','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-14','IUBYjr86','12345','부광시 무학로 63번길 136', '301호','더미철현',17900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-01','xoFTmj2','12345','부광시 무학로 63번길 136', '301호','더미철현',16900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-27','gBOxjO33','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-17','oNaynr78','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-25','EzMXPG3','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-06','kLUpoq33','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-28','pZEoCz88','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-26','DrOGnG62','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-10','VTOjAT49','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-28','XJyCZZ61','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-10','fcrovy98','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-06','EItSUp52','12345','부광시 무학로 63번길 136', '301호','더미철현',15900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-19','eDpBpw6','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-17','wYhyME2','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-06-21','JKHESW34','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-24','ovRTAz44','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-07','CsoHlu97','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-12','vZCDbi97','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-14','VTEKpP32','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-01','trOGTA24','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-29','nKpupq15','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-28','hESTaB30','12345','부광시 무학로 63번길 136', '301호','더미철현',64800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-18','baNJKX15','12345','부광시 무학로 63번길 136', '301호','더미철현',101800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-30','kEAtoR65','12345','부광시 무학로 63번길 136', '301호','더미철현',101800, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-04','wvDnWb84','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-18','WJueMS21','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-02','ogFdTo20','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-26','AzPciG70','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-07','WzUdCc60','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-16','mjRDRm11','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-13','lAujbT96','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-13','kztVZt81','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-14','xrdGjI5','12345','부광시 무학로 63번길 136', '301호','더미철현',149000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-18','mheOMS15','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-21','HMWkJe42','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-01','SVtlop17','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-22','dnRFMX55','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-01','ArzZSm10','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-06','MZvhZi26','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-06','zPGuUK34','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-03','qVNwgH95','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-23','oYAqbb1','12345','부광시 무학로 63번길 136', '301호','더미철현',64000, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-11','jdAuXP97','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-14','XaCPzj99','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-08','HeNkgE81','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-02','tVXDXC30','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-08','LStNSZ90','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-01-27','ernGLF68','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-12','kdqLJe48','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-07-17','pkOCwk5','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-09','yoztKG24','12345','부광시 무학로 63번길 136', '301호','더미철현',59900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-28','HUTEIN97','12345','부광시 무학로 63번길 136', '301호','더미철현',57900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-04-05','hIbeRR98','12345','부광시 무학로 63번길 136', '301호','더미철현',57900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-17','qolOaA24','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-11-13','jqfSLv55','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-15','xifHmX30','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-03-25','iuXvxb50','12345','부광시 무학로 63번길 136', '301호','더미철현',34900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-30','JpyLGs26','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-26','onOzMc39','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-12','zoraHk37','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-05-19','FvLCIa13','12345','부광시 무학로 63번길 136', '301호','더미철현',29900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-15','YBKnXk66','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-08-18','prCLTb96','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-02-10','MtUdiA8','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2023-03-03','FvDhzH99','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-12-19','FwGLoS28','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-10-19','bOuIGy97','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');
insert into user_order (ORDER_DATE,USER_ID, ADDRESS1, ADDRESS2, ADDRESS3, RECEIVER_NAME, ORDER_TOTAL_PRICE, RECEIVER_PHONE, status_for_admin)values ('2022-09-21','ixAXRA11','12345','부광시 무학로 63번길 136', '301호','더미철현',32900, '01077936953', '배송완료');


insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(19,'배송완료',1,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(20,'배송완료',2,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(21,'배송완료',3,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(22,'배송완료',4,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(23,'배송완료',5,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(24,'배송완료',6,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(36,'배송완료',7,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(37,'배송완료',8,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(38,'배송완료',9,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(39,'배송완료',10,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(40,'배송완료',11,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(41,'배송완료',12,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(42,'배송완료',13,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(43,'배송완료',14,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(44,'배송완료',15,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(45,'배송완료',16,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(46,'배송완료',17,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(51,'배송완료',18,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(52,'배송완료',19,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(53,'배송완료',20,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(54,'배송완료',21,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(72,'배송완료',22,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(73,'배송완료',23,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(74,'배송완료',24,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(75,'배송완료',25,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(76,'배송완료',26,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(77,'배송완료',27,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(78,'배송완료',28,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(79,'배송완료',29,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(80,'배송완료',30,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(81,'배송완료',31,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(120,'배송완료',32,1,16900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(145,'배송완료',33,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(146,'배송완료',34,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(147,'배송완료',35,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(148,'배송완료',36,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(160,'배송완료',37,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(161,'배송완료',38,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(162,'배송완료',39,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(163,'배송완료',40,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(164,'배송완료',41,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(165,'배송완료',42,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(202,'배송완료',43,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(203,'배송완료',44,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(204,'배송완료',45,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(205,'배송완료',46,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(256,'배송완료',47,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(257,'배송완료',48,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(258,'배송완료',49,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(259,'배송완료',50,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(260,'배송완료',51,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(261,'배송완료',52,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(262,'배송완료',53,1,101800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(263,'배송완료',54,1,101800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(334,'배송완료',55,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(335,'배송완료',56,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(336,'배송완료',57,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(337,'배송완료',58,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(338,'배송완료',59,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(339,'배송완료',60,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(340,'배송완료',61,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(341,'배송완료',62,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(342,'배송완료',63,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(343,'배송완료',64,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(344,'배송완료',65,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(345,'배송완료',66,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(346,'배송완료',67,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(347,'배송완료',68,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(348,'배송완료',69,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(349,'배송완료',70,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(350,'배송완료',71,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(351,'배송완료',72,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(352,'배송완료',73,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(353,'배송완료',74,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(354,'배송완료',75,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(355,'배송완료',76,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(356,'배송완료',77,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(357,'배송완료',78,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(358,'배송완료',79,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(359,'배송완료',80,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(360,'배송완료',81,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(361,'배송완료',82,1,57900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(362,'배송완료',83,1,57900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(447,'배송완료',84,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(448,'배송완료',85,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(449,'배송완료',86,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(450,'배송완료',87,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(451,'배송완료',88,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(452,'배송완료',89,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(453,'배송완료',90,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(454,'배송완료',91,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(469,'배송완료',92,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(470,'배송완료',93,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(471,'배송완료',94,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(472,'배송완료',95,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(473,'배송완료',96,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(474,'배송완료',97,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(475,'배송완료',98,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(19,'배송완료',99,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(20,'배송완료',100,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(21,'배송완료',101,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(22,'배송완료',102,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(23,'배송완료',103,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(24,'배송완료',104,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(36,'배송완료',105,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(37,'배송완료',106,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(38,'배송완료',107,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(39,'배송완료',108,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(40,'배송완료',109,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(41,'배송완료',110,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(42,'배송완료',111,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(43,'배송완료',112,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(44,'배송완료',113,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(45,'배송완료',114,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(46,'배송완료',115,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(51,'배송완료',116,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(52,'배송완료',117,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(53,'배송완료',118,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(54,'배송완료',119,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(72,'배송완료',120,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(73,'배송완료',121,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(74,'배송완료',122,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(75,'배송완료',123,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(76,'배송완료',124,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(77,'배송완료',125,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(78,'배송완료',126,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(79,'배송완료',127,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(80,'배송완료',128,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(81,'배송완료',129,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(120,'배송완료',130,1,16900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(145,'배송완료',131,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(146,'배송완료',132,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(147,'배송완료',133,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(148,'배송완료',134,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(160,'배송완료',135,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(161,'배송완료',136,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(162,'배송완료',137,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(163,'배송완료',138,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(164,'배송완료',139,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(165,'배송완료',140,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(202,'배송완료',141,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(203,'배송완료',142,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(204,'배송완료',143,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(205,'배송완료',144,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(256,'배송완료',145,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(257,'배송완료',146,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(258,'배송완료',147,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(259,'배송완료',148,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(260,'배송완료',149,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(261,'배송완료',150,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(262,'배송완료',151,1,101800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(263,'배송완료',152,1,101800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(334,'배송완료',153,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(335,'배송완료',154,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(336,'배송완료',155,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(337,'배송완료',156,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(338,'배송완료',157,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(339,'배송완료',158,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(340,'배송완료',159,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(341,'배송완료',160,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(342,'배송완료',161,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(343,'배송완료',162,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(344,'배송완료',163,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(345,'배송완료',164,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(346,'배송완료',165,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(347,'배송완료',166,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(348,'배송완료',167,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(349,'배송완료',168,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(350,'배송완료',169,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(351,'배송완료',170,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(352,'배송완료',171,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(353,'배송완료',172,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(354,'배송완료',173,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(355,'배송완료',174,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(356,'배송완료',175,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(357,'배송완료',176,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(358,'배송완료',177,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(359,'배송완료',178,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(360,'배송완료',179,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(361,'배송완료',180,1,57900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(362,'배송완료',181,1,57900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(447,'배송완료',182,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(448,'배송완료',183,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(449,'배송완료',184,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(450,'배송완료',185,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(451,'배송완료',186,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(452,'배송완료',187,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(453,'배송완료',188,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(454,'배송완료',189,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(469,'배송완료',190,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(470,'배송완료',191,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(471,'배송완료',192,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(472,'배송완료',193,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(473,'배송완료',194,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(474,'배송완료',195,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(475,'배송완료',196,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(19,'배송완료',197,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(20,'배송완료',198,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(21,'배송완료',199,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(22,'배송완료',200,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(23,'배송완료',201,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(24,'배송완료',202,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(36,'배송완료',203,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(37,'배송완료',204,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(38,'배송완료',205,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(39,'배송완료',206,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(40,'배송완료',207,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(41,'배송완료',208,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(42,'배송완료',209,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(43,'배송완료',210,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(44,'배송완료',211,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(45,'배송완료',212,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(46,'배송완료',213,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(51,'배송완료',214,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(52,'배송완료',215,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(53,'배송완료',216,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(54,'배송완료',217,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(72,'배송완료',218,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(73,'배송완료',219,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(74,'배송완료',220,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(75,'배송완료',221,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(76,'배송완료',222,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(77,'배송완료',223,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(78,'배송완료',224,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(79,'배송완료',225,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(80,'배송완료',226,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(81,'배송완료',227,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(120,'배송완료',228,1,16900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(145,'배송완료',229,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(146,'배송완료',230,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(147,'배송완료',231,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(148,'배송완료',232,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(160,'배송완료',233,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(161,'배송완료',234,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(162,'배송완료',235,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(163,'배송완료',236,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(164,'배송완료',237,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(165,'배송완료',238,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(202,'배송완료',239,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(203,'배송완료',240,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(204,'배송완료',241,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(205,'배송완료',242,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(256,'배송완료',243,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(257,'배송완료',244,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(258,'배송완료',245,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(259,'배송완료',246,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(260,'배송완료',247,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(261,'배송완료',248,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(262,'배송완료',249,1,101800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(263,'배송완료',250,1,101800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(334,'배송완료',251,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(335,'배송완료',252,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(336,'배송완료',253,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(337,'배송완료',254,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(338,'배송완료',255,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(339,'배송완료',256,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(340,'배송완료',257,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(341,'배송완료',258,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(342,'배송완료',259,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(343,'배송완료',260,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(344,'배송완료',261,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(345,'배송완료',262,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(346,'배송완료',263,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(347,'배송완료',264,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(348,'배송완료',265,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(349,'배송완료',266,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(350,'배송완료',267,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(351,'배송완료',268,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(352,'배송완료',269,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(353,'배송완료',270,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(354,'배송완료',271,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(355,'배송완료',272,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(356,'배송완료',273,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(357,'배송완료',274,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(358,'배송완료',275,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(359,'배송완료',276,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(360,'배송완료',277,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(361,'배송완료',278,1,57900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(362,'배송완료',279,1,57900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(447,'배송완료',280,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(448,'배송완료',281,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(449,'배송완료',282,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(450,'배송완료',283,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(451,'배송완료',284,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(452,'배송완료',285,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(453,'배송완료',286,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(454,'배송완료',287,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(469,'배송완료',288,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(470,'배송완료',289,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(471,'배송완료',290,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(472,'배송완료',291,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(473,'배송완료',292,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(474,'배송완료',293,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(475,'배송완료',294,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(19,'배송완료',295,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(20,'배송완료',296,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(21,'배송완료',297,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(22,'배송완료',298,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(23,'배송완료',299,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(24,'배송완료',300,1,49900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(36,'배송완료',301,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(37,'배송완료',302,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(38,'배송완료',303,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(39,'배송완료',304,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(40,'배송완료',305,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(41,'배송완료',306,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(42,'배송완료',307,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(43,'배송완료',308,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(44,'배송완료',309,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(45,'배송완료',310,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(46,'배송완료',311,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(51,'배송완료',312,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(52,'배송완료',313,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(53,'배송완료',314,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(54,'배송완료',315,1,27900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(72,'배송완료',316,1,19900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(73,'배송완료',317,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(74,'배송완료',318,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(75,'배송완료',319,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(76,'배송완료',320,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(77,'배송완료',321,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(78,'배송완료',322,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(79,'배송완료',323,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(80,'배송완료',324,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(81,'배송완료',325,1,17900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(120,'배송완료',326,1,16900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(145,'배송완료',327,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(146,'배송완료',328,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(147,'배송완료',329,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(148,'배송완료',330,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(160,'배송완료',331,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(161,'배송완료',332,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(162,'배송완료',333,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(163,'배송완료',334,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(164,'배송완료',335,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(165,'배송완료',336,1,15900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(202,'배송완료',337,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(203,'배송완료',338,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(204,'배송완료',339,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(205,'배송완료',340,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(256,'배송완료',341,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(257,'배송완료',342,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(258,'배송완료',343,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(259,'배송완료',344,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(260,'배송완료',345,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(261,'배송완료',346,1,64800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(262,'배송완료',347,1,101800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(263,'배송완료',348,1,101800);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(334,'배송완료',349,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(335,'배송완료',350,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(336,'배송완료',351,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(337,'배송완료',352,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(338,'배송완료',353,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(339,'배송완료',354,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(340,'배송완료',355,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(341,'배송완료',356,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(342,'배송완료',357,1,149000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(343,'배송완료',358,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(344,'배송완료',359,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(345,'배송완료',360,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(346,'배송완료',361,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(347,'배송완료',362,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(348,'배송완료',363,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(349,'배송완료',364,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(350,'배송완료',365,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(351,'배송완료',366,1,64000);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(352,'배송완료',367,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(353,'배송완료',368,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(354,'배송완료',369,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(355,'배송완료',370,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(356,'배송완료',371,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(357,'배송완료',372,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(358,'배송완료',373,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(359,'배송완료',374,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(360,'배송완료',375,1,59900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(361,'배송완료',376,1,57900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(362,'배송완료',377,1,57900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(447,'배송완료',378,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(448,'배송완료',379,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(449,'배송완료',380,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(450,'배송완료',381,1,34900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(451,'배송완료',382,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(452,'배송완료',383,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(453,'배송완료',384,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(454,'배송완료',385,1,29900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(469,'배송완료',386,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(470,'배송완료',387,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(471,'배송완료',388,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(472,'배송완료',389,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(473,'배송완료',390,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(474,'배송완료',391,1,32900);
insert into userOrder_detail(PRODUCT_OPT_IDX,ORDER_DETAIL_STATUS, USER_ORDER_IDX, PRODUCT_COUNT, PRODUCT_PRICE) values(475,'배송완료',392,1,32900);

insert into notice(NOTICE_WRITER,NOTICE_TITLE,NOTICE_CONTENT,SHOW_CHECK) values ('관리자',' 신규 가입 회원 쿠폰 안내','신규 회원가입을 하시면

즉시 사용 가능한 3,000원 쿠폰을 드립니다.





대상 : 쇼핀 신규 가입 고객

조건 : 5만원 이상 구매시 사용 가능

제외상품 : 세일상품,특가상품 제외

사용기한 : 발급 후 30일','Y');
insert into notice(NOTICE_WRITER,NOTICE_TITLE,NOTICE_CONTENT,SHOW_CHECK) values ('관리자','CK2J 업무시간','평일 AM 10:00 - PM 05:00

점심 PM 12:00 - PM 01:00



토/일요일 및 공휴일 휴무','Y');
insert into notice(NOTICE_WRITER,NOTICE_TITLE,NOTICE_CONTENT,SHOW_CHECK) values ('관리자','네이버페이 도서산간 추가배송비 안내','항상 쇼핀을 이용해주셔서 감사드립니다.



네이버 페이 연동 완료후

도서산간지역(제주도포함)에 사시는 고객님께서는

네이버페이 결제시에 

도서산간 지역 별도 배송비가

계산이 안되어 결제되기 때문에

추가로 저희쪽에 입금을 해주시거나 착불로 받아보셔야 합니다.

이 부분 양해 부탁드립니다.



제주도 추가 3,000원/ 제주 외 도서지역 추가 5,000원/ 지역별 차등
(제주도 우도 등...지역별로 도선료가 추가되는 지역은 최대 8,000원 추가)


감사합니다.



계좌번호 / 기업은행 063-080907-01019 송진우','Y');
insert into notice(NOTICE_WRITER,NOTICE_TITLE,NOTICE_CONTENT,SHOW_CHECK) values ('관리자','휴대폰결제 취소 수수료 안내','휴대폰 결제 취소 관련하여 안내 드립니다.





휴대폰결제는 결제 특성상 당월(영업시간내)이 지나면 결제 취소가 불가능합니다.



예를 들어,

1월에 결제하신 내용은 해당월인 1월 안에만 취소가 가능합니다.

(1월 31일에 결제 후 2월 1일 취소시 불가능)



현재 쇼핀이 이용 중인 모바일 결제(휴대폰 결제)는 'KG 모빌리언스'입니다.



모든 휴대폰결제 PG사는 당월만 결제 취소가 가능한 서비스입니다.

(※ 이동통신사 정책에 의해 결제월이 지난 이후 결제 취소 불가)

(※ 휴대폰결제 부분취소 역시 동일한 방법으로 진행)


------



휴대폰결제 취소 가능일은 결제하신 당월(1일 -말일) 안에서만 취소가 가능하며



결제월이 지난 경우 이미 통신사에 결제요금이 부과되어 취소가 절대 불가능합니다.



------



단, 취소를 원하시는 경우



현금 환불 or 적립금 환불은 가능합니다.



1.현금 환불: 휴대폰결제 중 총 3.8%를 제한 금액을 현금 환불 처리 가능합니다.



2.적립금 환불: 적립금 환불시 수수료 없이 환불 가능합니다.



(※ 수수료는 저희 수입이 아닌, 휴대폰 결제 수수료로 들어가는 부분입니다.)





------



휴대폰결제는 당월 말일까지만 취소가능하니 이점 참고 부탁드립니다.','Y');
insert into notice(NOTICE_WRITER,NOTICE_TITLE,NOTICE_CONTENT,SHOW_CHECK) values ('관리자','<안내> IOS 11.3버전 카드,휴대폰결제 안내 가이드','현재아이폰 IOS의 11.3버전에서 카드및 휴대폰 결제가 안되는 현상이 있어 안내드립니다.



아이폰 IOS의 11.3버전에서 안심클릭 카드결제와 휴대폰 결제가 가능한 방법에 대해 안내 드립니다.


','Y');
insert into notice(NOTICE_WRITER,NOTICE_TITLE,NOTICE_CONTENT,SHOW_CHECK) values ('관리자','쇼핀 사무실 이전 및 택배사 변경 안내','[사무실 이전 안내]



2019년 7월 26일 사무실 이전으로 모든 배송업무 및 고객센터 업무가 중단됩니다.

고객님의 너른 양해 부탁드립니다.



사무실 이전일

2019년 7월 26일 / 이사 당일에는 고객센터 업무 및 택배발송을 포함한 모든 업무가 중단됩니다.



배송 안내

재고가 있는 상품에 한하여, 7월 25일 오후 3시 이전 결제건은 7월 25일까지 모두 정상 발송됩니다.

미배송 주문건 및 7월 25일 오후 3시 이후 주문건은 7월 29일부터 발송됩니다.','Y');
insert into notice(NOTICE_WRITER,NOTICE_TITLE,NOTICE_CONTENT,SHOW_CHECK) values ('관리자','배송 휴무 안내 (2023년 3월 3일 금요일)','배송 휴무 안내





물류센터 이전으로 인해 

3월 19일 발송업무가 중단되오니

고객님의 많은 양해부타드립니다.



발송 휴무일 : 3월 19일 (금)

출고 날짜 : 3월 22일 (월) 정상 배송



더 나은 배송 서비스로 보답하겠습니다.

감사합니다.





※ 고객센터 및 주문은 정상 운영됩니다.','Y');
insert into notice(NOTICE_WRITER,NOTICE_TITLE,NOTICE_CONTENT,SHOW_CHECK) values ('관리자','2022년 2월 9일 고객센터 이전에 따른 휴무 안내','안녕하세요 



CK2J입니다. 고객센터 이전으로 인하여 



2월 9일 수요일 고객센터 업무가 하루 쉬게 됨을 양해 부탁드립니다.

2월 10일 목요일 부터 고객센터 업무가 진행 될 예정입니다.



고객센터업무 : 상담톡 , 상담전화, 게시판, 교환/반품처리 



항상 고객님과 소통하는 CK2J가 되겠습니다.



불편을 드려 죄송 합니다 ','Y');
insert into notice(NOTICE_WRITER,NOTICE_TITLE,NOTICE_CONTENT,SHOW_CHECK) values ('관리자','<공지> 일부 상품 가격 인상 안내','안녕하세요 



CK2J입니다. 

최근 급격하게 오른 원/부자재 가격 및 운송비 상승으로 인하여 

2022년 6월 21일 부로 부득이 하게 

일부 제품에 한해서 가격 조정을 하게 되었습니다. 



고객님들의 양해를 부탁드리며 

더좋은 상품과 서비스로 보답하는 CK2J가 되겠습니다. 



감사합니다.','Y');
insert into notice(NOTICE_WRITER,NOTICE_TITLE,NOTICE_CONTENT,SHOW_CHECK) values ('관리자','무료배송 금액 기준 변경 안내','무료배송 금액 기준 변경 안내



▶ 변경내용 : 주문금액 70,000원 이상 주문시 무료배송



▶ 적용일시 : 2022년 09월 06일 



 앞으로도 더욱 멋진 제품과 서비스로 고객만족을 위해 항상 노력하겠습니다.



감사합니다.
','Y');



commit;

