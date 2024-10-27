ALTER TABLE "questions_groups" RENAME TO "question_groups";--> statement-breakpoint
ALTER TABLE "questions_sets" RENAME TO "question_sets";--> statement-breakpoint
ALTER TABLE "question_sets" DROP CONSTRAINT "questions_sets_name_unique";--> statement-breakpoint
ALTER TABLE "question_groups" DROP CONSTRAINT "questions_groups_question_set_id_questions_sets_id_fk";
--> statement-breakpoint
ALTER TABLE "questions" DROP CONSTRAINT "questions_question_set_id_questions_sets_id_fk";
--> statement-breakpoint
ALTER TABLE "questions" DROP CONSTRAINT "questions_question_group_id_questions_groups_id_fk";
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "question_groups" ADD CONSTRAINT "question_groups_question_set_id_question_sets_id_fk" FOREIGN KEY ("question_set_id") REFERENCES "public"."question_sets"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "questions" ADD CONSTRAINT "questions_question_set_id_question_sets_id_fk" FOREIGN KEY ("question_set_id") REFERENCES "public"."question_sets"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "questions" ADD CONSTRAINT "questions_question_group_id_question_groups_id_fk" FOREIGN KEY ("question_group_id") REFERENCES "public"."question_groups"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "question_sets" ADD CONSTRAINT "question_sets_name_unique" UNIQUE("name");