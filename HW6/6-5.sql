USE cs122a_fall20;

DELIMITER //
CREATE PROCEDURE RegisterChecker(
    user_id integer,
    name_first varchar(50),
    name_last varchar(50), 
    email varchar(100),
    password varchar(30),
    profile_pic varchar(500),
    address_country varchar(30),
    address_state varchar(30),
    address_city varchar(30),                                            
    office_number varchar(20)
)
BEGIN 
    insert into User
    values( user_id, name_first, name_last, email, password, NOW(), profile_pic, address_country, address_state, address_city );
	insert into Checker
	values( user_id, NOW() );
	insert into Phone
	values( user_id, 'OFFICE', office_number);
END;  //
DELIMITER ;


-- 
-- Question 5b (query to execute)
-- 
CALL cs122a_fall20.RegisterChecker (
   3000,
   "Peter",
   "Anteater",
   "peter-anteater2020@gmail.com",
   "pretend-this-is-hashed",
   null, 
   "USA",
   "California",
   "Irvine",
   "(949) 824-5011"
);

SELECT U.user_id, U.email, U.profile_pic, C.checker_since, P.number, P.kind
FROM User U, Checker C, Phone P
WHERE U.user_id = C.user_id AND 
      P.user_id = C.user_id AND
	  U.user_id = 3000;