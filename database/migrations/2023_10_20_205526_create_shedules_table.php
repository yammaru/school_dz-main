<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateShedulesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('shedules', function (Blueprint $table) {


            $table->increments('id');
            $table->char('day',1);
            $table->char('end_time', 8); 
            $table->char('start_time', 8); 
            $table->integer('course_group_id')->unsigned();
            $table->foreign('course_group_id')->references('id')->on('course_groups')->onDelete('cascade');
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
        Schema::dropIfExists('shedules');
    }
}
