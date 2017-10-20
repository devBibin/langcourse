CREATE TABLE "Test" (
	"id" serial NOT NULL,
	"test_theme" TEXT(1000) NOT NULL,
	"test_introduction" TEXT(5000) NOT NULL,
	"test_time_length" TIMESTAMP,
	"test_to_type_id" integer NOT NULL,
	"test_to_language_id" integer NOT NULL,
	"test_to_language_section_id" integer NOT NULL,
	CONSTRAINT Test_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Language" (
	"id" serial NOT NULL,
	"language_name" TEXT(50) NOT NULL,
	CONSTRAINT Language_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Test_type" (
	"id" serial NOT NULL,
	"test_type_name" serial NOT NULL,
	CONSTRAINT Test_type_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Language_section" (
	"id" serial NOT NULL,
	"language_section_name" integer NOT NULL,
	CONSTRAINT Language_section_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Question body" (
	"id" serial NOT NULL,
	"question_text" VARCHAR(1000) NOT NULL,
	"question_rating" integer NOT NULL,
	"question_answers_count" integer NOT NULL DEFAULT '0',
	"questions_answers_count_right" integer NOT NULL DEFAULT '0',
	"question_to_test_id" integer NOT NULL,
	"question_to_language_section_id" integer NOT NULL DEFAULT '0',
	"question_to_answer_id" integer NOT NULL DEFAULT '0',
	CONSTRAINT Question body_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Answer_body" (
	"id" serial NOT NULL,
	"answer_annotation" TEXT(1000),
	"answer_to_type_id" integer NOT NULL,
	CONSTRAINT Answer_body_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Answer_type" (
	"id" serial NOT NULL,
	"answer_type_tbl_name" serial NOT NULL,
	CONSTRAINT Answer_type_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Simple choice" (
	"id" serial NOT NULL,
	"choice_text" TEXT(1000) NOT NULL,
	"choice_is_right" BOOLEAN NOT NULL,
	"choce_to_answer_id" integer NOT NULL,
	CONSTRAINT Simple choice_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Task" (
	"id" serial NOT NULL,
	"task_text" TEXT(1000) NOT NULL,
	"task_to_answer_id" integer NOT NULL,
	"task_to_correct_choice_id" integer NOT NULL,
	"task_to_choices_id" integer NOT NULL,
	CONSTRAINT Task_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Table_choice_variants" (
	"id" serial NOT NULL,
	"choice_text" TEXT(1000) NOT NULL,
	"choice_to_task_id" integer NOT NULL,
	CONSTRAINT Table_choice_variants_pk PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "Test" ADD CONSTRAINT "Test_fk0" FOREIGN KEY ("test_to_type_id") REFERENCES "Test_type"("id");
ALTER TABLE "Test" ADD CONSTRAINT "Test_fk1" FOREIGN KEY ("test_to_language_id") REFERENCES "Language"("id");
ALTER TABLE "Test" ADD CONSTRAINT "Test_fk2" FOREIGN KEY ("test_to_language_section_id") REFERENCES "Language_section"("id");




ALTER TABLE "Question body" ADD CONSTRAINT "Question body_fk0" FOREIGN KEY ("question_to_test_id") REFERENCES "Test"("id");
ALTER TABLE "Question body" ADD CONSTRAINT "Question body_fk1" FOREIGN KEY ("question_to_language_section_id") REFERENCES "Language_section"("id");
ALTER TABLE "Question body" ADD CONSTRAINT "Question body_fk2" FOREIGN KEY ("question_to_answer_id") REFERENCES "Answer_body"("id");

ALTER TABLE "Answer_body" ADD CONSTRAINT "Answer_body_fk0" FOREIGN KEY ("answer_to_type_id") REFERENCES "Answer_type"("id");


ALTER TABLE "Simple choice" ADD CONSTRAINT "Simple choice_fk0" FOREIGN KEY ("choce_to_answer_id") REFERENCES "Answer_body"("id");

ALTER TABLE "Task" ADD CONSTRAINT "Task_fk0" FOREIGN KEY ("task_to_answer_id") REFERENCES "Answer_body"("id");
ALTER TABLE "Task" ADD CONSTRAINT "Task_fk1" FOREIGN KEY ("task_to_choices_id") REFERENCES "Table_choice_variants"("id");

ALTER TABLE "Table_choice_variants" ADD CONSTRAINT "Table_choice_variants_fk0" FOREIGN KEY ("choice_to_task_id") REFERENCES "Task"("id");

