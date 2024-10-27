ALTER TABLE "question_groups" ADD COLUMN "group_number" integer DEFAULT 1 NOT NULL;--> statement-breakpoint
ALTER TABLE "questions" DROP COLUMN IF EXISTS "group_number";