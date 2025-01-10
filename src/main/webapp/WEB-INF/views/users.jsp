
<style>
    .select2-container .select2-selection--single {
        height: 38px;
    }

    .modal-body {
        max-height: 500px; /* Sesuaikan tinggi sesuai kebutuhan */
        overflow-y: auto;  /* Aktifkan scroll vertikal jika konten melebihi tinggi */
    }
</style>

<!-- Tabel menggunakan AdminLTE -->
<div class="card">
    <div class="card-header">
        <div class="d-flex justify-content-between w-100">
            <!-- Tombol di sebelah kiri -->
            <div class="d-flex">
                <a href="#" class="btn btn-primary mr-2" id="addBtn">Add New Users</a>
                <!-- ${pageContext.request.contextPath}/stock/add-stock -->
            </div>
            
            <!-- Tombol dan filter di sebelah kanan -->
            <div class="card-tools">
                <div class="row">
                    <div class="col-md-3">
                        <!-- Filter Item Code -->
                        <input type="text" id="itemCodeFilter" class="form-control" placeholder="Filter by Item Code" />
                    </div>
                    <div class="col-md-3">
                        <!-- Tombol Search -->
                        <button class="btn btn-success" id="searchBtn">Search</button>
                    </div>
                    <div class="col-md-3">
                        <!-- Tombol Excel -->
                        <button class="btn btn-info" id="excelBtn" onclick="downloadExcel()">Download Excel</button>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
    <!-- /.card-header -->
    <div class="card-body">
        <div id="jqxgrid"></div>
    </div>
    <!-- /.card-body -->
</div>
<!-- /.card -->

<script type="text/javascript">
    $(document).ready(function () {
        handleStockDataResponse('/users/all', '#jqxgrid', userColumns);
    });

    // column
    var userColumns = [
        { 
            text: "No", 
            datafield: "id", 
            width: 60, 
            cellsrenderer: function (row, column, value, rowData, columnData) {
                // Menggunakan row index untuk menghasilkan nomor urut
                return '<div style="text-align: center; margin-top: 7px;">' + (row + 1) + '</div>';
            } 
        },           // Lebar untuk No
        { text: 'Username', datafield: 'username', width: '15%' },
        { text: 'Password', datafield: 'password', width: '15%' },
        { text: 'Role', datafield: 'role', width: '15%' }
    ];

    function initializeGrid(gridId, columns, dataAdapter) {
        $(gridId).jqxGrid({
            width: '100%',
            height: '100%',  /* Mengatur tinggi grid */
            autoheight: false,  /* Nonaktifkan autoheight */
            pageable: true,
            pagesize: 10, // Show 10 rows per page
            source: dataAdapter,
            columnsresize: true,
            pagerMode: 'default',
            // selectionmode: 'checkbox',
            columns: columns,
            sortable: true,
            showfilterrow: true,
            filterable: true,
            enablebrowserselection: true,
            keyboardnavigation: false,
            pagesize: 20,
            pagesizeoptions: ['20', '50', '100'],
        });
    }

    // handle jqxgrid
    function handleStockDataResponse(url, gridId, columns) {
        let params = {};
        
        // Lakukan AJAX request
        $.ajax({
            url: url,
            method: 'GET',
            data: params, // Hanya mengirim parameter jika ada
            success: function (data) {
                // console.log('Hasil data:', data);

                // Proses data untuk grid
                const userData = data.map((item, index) => ({
                    id: index + 1, // Nomor urut berdasarkan index
                    username: item.username,
                    password: item.password,
                    role: item.role
                }));

                // Siapkan data adapter untuk grid
                const source = {
                    localdata: userData,
                    datatype: "array",
                    datafields: columns.map(col => ({ name: col.datafield, type: 'string' }))
                };

                const dataAdapter = new $.jqx.dataAdapter(source);

                // Reinitialize jqxGrid dengan data yang diperbarui
                initializeGrid(gridId, columns, dataAdapter);
            },
            error: function (err) {
                console.log('Error fetching data from API:', err);
            }
        });
    }
</script>