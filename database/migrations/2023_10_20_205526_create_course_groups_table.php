<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCourseGroupsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('course_groups', function (Blueprint $table) {


            $table->increments('id');
            $table->string('name');
            $table->integer('instructor_id')->unsigned();
            $table->foreign('instructor_id')->references('id')->on('users')->onDelete('cascade');
            $table->integer('curso_id')->unsigned();
            $table->foreign('curso_id')->references('id')->on('webinars')->onDelete('cascade');


            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('course_groups');
    }
}
