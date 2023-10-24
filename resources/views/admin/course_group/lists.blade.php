@extends('admin.layouts.app')

@push('libraries_top')

@endpush

@section('content')
<section class="section">
    <div class="section-header">
        <h1>Lista de grupos</h1>
        <div class="section-header-breadcrumb">
            <div class="breadcrumb-item active"><a href="{{ getAdminPanelUrl() }}">{{trans('admin/main.dashboard')}}</a>
            </div>
            <div class="breadcrumb-item">Grupo</div>
        </div>
    </div>

    <div class="section-body">

        <div class="row">
            <div class="col-12 col-md-12">
                <div class="card">
                    <div class="card-header">

                        <a href="{{ getAdminPanelUrl() }}/grupos/create" class="btn btn-primary">Agregar Nuevo Grupo</a>

                    </div>

                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped font-14">
                                <tr>
                                    <th>id</th>
                                    <th class="text-left">Nombre</th>
                                    <th>Instructor</th>
                                    <th>Curso</th>
                                    <th>Horario</th>
                                </tr>
                                @foreach($categories as $category)
                                @if ($category)
                                <tr>
                                    <td>
                                        {{$category['id']}}
                                    </td>

                                    <td class="text-left">{{$category['name']}}</td>
                                    <td>{{$category['teacher']['full_name']}}</td>
                                    <td>{{$category['curso']['slug']}}</td>
                                    <td>
                                        @include('admin.includes.modal_button',[
                                        'code'=>'Horario|
                                        

                                        ',
                                        'url' => '/admin/grupos',
                                        'tooltip' => 'Ver Horario',
                                        'btnClass' => '',
                                        'btnIcon' => 'fa-eye',
                                        ])
                                    </td>
                                </tr>
                                @endif
                                @endforeach
                            </table>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</section>
<div class="modal fade" id="modalEjemplo" tabindex="-1" role="dialog" aria-labelledby="modalEjemploLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalEjemploLabel">Horario</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Contenido del modal aquí -->
            </div>
        </div>
    </div>
</div>
@endsection
<script>
    $(document).ready(function() {
        $('#modalEjemplo').on('show.bs.modal', function(event) {
            var button = $(event.relatedTarget); // El botón que abrió el modal
            var horarios = JSON.parse(button.data('horarios'));
            // Convierte el atributo JSON en un objeto
            console.log(horarios);
            // Construye el contenido del modal con los datos de horarios
            var modalContent = '<table class="table table-bordered">';
            modalContent += '<thead><tr><th>Día</th><th>Hora de Inicio</th><th>Hora de Finalización</th></tr></thead>';
            modalContent += '<tbody>';
            horarios.forEach(function(item) {
                modalContent += '<tr><td>' + item['day'] + '</td><td>' + item['startTime'] + '</td><td>' + item['endTime'] + '</td></tr>';
            });
            modalContent += '</tbody></table>';

            // Actualiza el contenido del modal
            $(this).find('.modal-body').html(modalContent);
        });
    });
</script>