<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStudyPlanTextLessonsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('study_plan_text_lessons', function (Blueprint $table) {
            $table->engine = 'InnoDB';

            $table->increments('id');
            $table->integer('creator_id')->unsigned();
            $table->integer('webinar_id')->unsigned();
            $table->integer('chapter_id')->unsigned();
            $table->string('title');
            $table->longText('content')->nullable();
            $table->integer('order')->unsigned();
            $table->integer('created_at')->unsigned();
            $table->integer('updated_at')->unsigned()->nullable();

            $table->foreign('creator_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('webinar_id')->references('id')->on('webinars')->onDelete('cascade');
            $table->foreign('chapter_id')->references('id')->on('study_plan_chapters')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('study_plan_text_lessons');
    }
}
