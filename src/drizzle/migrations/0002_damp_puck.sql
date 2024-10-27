CREATE TABLE IF NOT EXISTS "questions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"question_set_id" uuid NOT NULL,
	"question_group_id" uuid NOT NULL,
	"question" text NOT NULL,
	"question_self" text NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"is_reverse" boolean DEFAULT false NOT NULL,
	"is_open" boolean DEFAULT false NOT NULL,
	"sort_order" integer DEFAULT 99 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "questions_groups" DROP CONSTRAINT "questions_groups_question_group_id_questions_groups_id_fk";
--> statement-breakpoint
ALTER TABLE "questions_groups" ADD COLUMN "name" text NOT NULL;--> statement-breakpoint
ALTER TABLE "questions_groups" ADD COLUMN "description" text NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "questions" ADD CONSTRAINT "questions_question_set_id_questions_sets_id_fk" FOREIGN KEY ("question_set_id") REFERENCES "public"."questions_sets"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "questions" ADD CONSTRAINT "questions_question_group_id_questions_groups_id_fk" FOREIGN KEY ("question_group_id") REFERENCES "public"."questions_groups"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "questions_groups" DROP COLUMN IF EXISTS "question_group_id";--> statement-breakpoint
ALTER TABLE "questions_groups" DROP COLUMN IF EXISTS "question";--> statement-breakpoint
ALTER TABLE "questions_groups" DROP COLUMN IF EXISTS "question_self";--> statement-breakpoint
ALTER TABLE "questions_groups" DROP COLUMN IF EXISTS "is_reverse";--> statement-breakpoint
ALTER TABLE "questions_groups" DROP COLUMN IF EXISTS "is_open";