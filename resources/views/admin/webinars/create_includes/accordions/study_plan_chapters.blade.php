<div class="row mt-10">
    <div class="col-12">
        <div class="accordion-content-wrapper mt-15" id="chapterAccordion" role="tablist" aria-multiselectable="true">
            @if(!empty($webinar->studyPlanChapters) and count($webinar->studyPlanChapters))
                <ul class="draggable-content-lists draggable-lists-chapter" data-drag-class="draggable-lists-chapter" data-order-table="study_plan_chapters">
                    @foreach($webinar->studyPlanChapters as $chapter)
                        <li data-id="{{ !empty($chapter) ? $chapter->id :'' }}" data-chapter-order="{{ $chapter->order }}" class="accordion-row bg-white rounded-sm mt-20 py-15 py-lg-30 px-10 px-lg-20">
                            <div class="d-flex align-items-center justify-content-between " role="tab" id="chapter_{{ !empty($chapter) ? $chapter->id :'record' }}">
                                <div class="d-flex align-items-center" href="#collapseChapter1{{ !empty($chapter) ? $chapter->id :'record' }}" aria-controls="collapseChapter1{{ !empty($chapter) ? $chapter->id :'record' }}" data-parent="#chapterAccordion" role="button" data-toggle="collapse" aria-expanded="true">
                                    <span class="chapter-icon mr-10">
                                        <i data-feather="grid" class=""></i>
                                    </span>
                                    <div class="">
                                        <span class="font-weight-bold text-dark-blue d-block cursor-pointer">{{ !empty($chapter) ? $chapter->title : trans('public.add_new_chapter') }}</span>
                                    </div>
                                </div>

                                <div class="d-flex align-items-center">

                                    <div class="btn-group dropdown table-actions">
                                        <button type="button" class="add-course-content-btn mr-10 dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <i data-feather="plus" class=""></i>
                                        </button>
                                        <div class="dropdown-menu ">
                                            <button type="button" class="js-add-course-content-btn d-block mb-10 btn-transparent" data-webinar-id="{{ $webinar->id }}" data-type="study_plan" data-chapter="{{ !empty($chapter) ? $chapter->id :'' }}">
                                                {{ trans('public.add_item') }}
                                            </button>
                                        </div>
                                    </div>

                                    <button type="button" class="js-add-study_plan_chapter btn-transparent text-gray" data-webinar-id="{{ $webinar->id }}" data-chapter="{{ $chapter->id }}" data-title="{{ $chapter->title }}" data-content="{{ $chapter->content }}">
                                        <i data-feather="edit-3" class="mr-10 cursor-pointer" height="20"></i>
                                    </button>

                                    <a href="{{ getAdminPanelUrl() }}/study_plan_chapters/{{ $chapter->id }}/delete" class="delete-action btn btn-sm btn-transparent text-gray">
                                        <i data-feather="trash-2" class="mr-10 cursor-pointer" height="20"></i>
                                    </a>

                                    <i data-feather="move" class="move-icon mr-10 cursor-pointer text-gray" height="20"></i>

                                    <i class="collapse-chevron-icon feather-chevron-up text-gray" data-feather="chevron-down" height="20" href="#collapseChapter1{{ !empty($chapter) ? $chapter->id :'record' }}" aria-controls="collapseChapter1{{ !empty($chapter) ? $chapter->id :'record' }}" data-parent="#chapterAccordion" role="button" data-toggle="collapse" aria-expanded="true"></i>
                                </div>
                            </div>


                            <div id="collapseChapter1{{ !empty($chapter) ? $chapter->id :'record' }}" aria-labelledby="chapter_{{ !empty($chapter) ? $chapter->id :'record' }}" class=" collapse show" role="tabpanel">
                                <div class="panel-collapse text-gray">

                                    <div class="accordion-content-wrapper mt-15" id="chapterContentAccordion{{ !empty($chapter) ? $chapter->id :'' }}" role="tablist" aria-multiselectable="true">
                                        @if(!empty($chapter->textLessons))
                                            <ul class="draggable-content-lists draggable-lists-chapter-{{ $chapter->id }}" data-drag-class="draggable-lists-chapter-{{ $chapter->id }}" data-order-table="study_plan_text_lessons">
                                                @foreach($chapter->textLessons as $textLesson)
                                                    @include('admin.webinars.create_includes.accordions.study_plan_text_lesson' ,['textLesson' => $textLesson , 'chapter' => $chapter,])
                                                @endforeach
                                            </ul>
                                        @else
                                            @include(getTemplate() . '.includes.no-result',[
                                                'file_name' => 'meet.png',
                                                'title' => trans('update.chapter_content_no_result'),
                                                'hint' => trans('update.chapter_content_no_result_hint'),
                                            ])
                                        @endif
                                    </div>

                                </div>
                            </div>
                        </li>
                    @endforeach
                </ul>
            @else
                @include(getTemplate() . '.includes.no-result',[
                    'file_name' => 'meet.png',
                    'title' => trans('update.chapter_no_result'),
                    'hint' => trans('update.chapter_no_result_hint'),
                ])
            @endif
        </div>

    </div>
</div>

