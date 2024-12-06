<style>
    .select2-container .select2-selection--single {
        height: 38px;
    }

    .modal-body {
        max-height: 500px; /* Sesuaikan tinggi sesuai kebutuhan */
        overflow-y: auto;  /* Aktifkan scroll vertikal jika konten melebihi tinggi */
    }
</style>

<div class="row">
    <div class="col-md-12">
         <!-- Tabel menggunakan AdminLTE -->
        <div class="card">
            <div class="card-header">
                <!-- Form untuk Filter dan Search -->
                    <div class="row">
                        <div class="col-md-2">
                            <!-- Filter Item Code -->
                            <input type="text" id="itemCodeFilter" class="form-control" placeholder="Filter by Item Code" />
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="far fa-calendar-alt"></i>
                                    </span>
                                    </div>
                                    <input type="text" class="form-control float-right" id="reservation">
                                </div>
                                <!-- /.input group -->
                            </div>
                        </div>
                        <div class="col-md-1">
                            <!-- Tombol Search -->
                            <button class="btn btn-success" id="searchBtn">Search</button>
                        </div>
                        <div class="col-md-3">
                            <!-- Tombol Excel -->
                            <button class="btn btn-info" id="excelBtn">Export Excel</button>
                        </div>
                    </div>  
            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <!-- Tabel jqxGrid -->
                <div id="jqxgrid"></div>
            </div>
            <!-- /.card-body -->
        </div>
    <!-- /.card -->
    </div>
   
</div>

<!-- Script untuk menginisialisasi DataTables -->
<script type="text/javascript">
    // Fungsi untuk mengambil lokasi dari API dan mengisi dropdown
    function loadLocations() {
        fetch('/master/api/locations')
            .then(response => response.json())
            .then(data => {
                const locationFilter = document.getElementById('locationFilter');
                locationFilter.innerHTML = '<option value="">Select Location</option>';
                data.forEach(location => {
                    const option = document.createElement('option');
                    option.value = location.locCd;
                    option.textContent = location.location;
                    locationFilter.appendChild(option);
                });
            })
            .catch(error => {
                console.error('Error fetching locations:', error);
            });
    }

    $(document).ready(function () {
        loadLocations();

        // $('#dateFilter').daterangepicker({
        //     autoUpdateInput: false, // Menonaktifkan update otomatis input
        //     locale: {
        //         cancelLabel: 'Clear', // Menambahkan tombol untuk membersihkan input
        //         format: 'YYYY-MM-DD'  // Format tanggal yang diinginkan
        //     }
        // });

        // // Menangani event saat tanggal dipilih
        // $('#dateFilter').on('apply.daterangepicker', function(ev, picker) {
        //     $(this).val(picker.startDate.format('YYYY-MM-DD') + ' - ' + picker.endDate.format('YYYY-MM-DD'));
        // });

        // $('#dateFilter').on('cancel.daterangepicker', function(ev, picker) {
        //     $(this).val(''); // Membersihkan input saat tombol "Clear" diklik
        // });

        $('#reservation').daterangepicker();

        // Ambil data transaksi menggunakan AJAX
        $.ajax({
            url: '/transactions/all', // Ganti dengan endpoint transaksi Anda
            method: 'GET',
            success: function(data) {
                // Modifikasi response jika perlu (misalnya mengganti 'transNo' menjadi 'no' atau menambah informasi lainnya)
                data = data.map(function(item, index) {
                    item.no = index + 1; // Menambahkan 'no' berdasarkan index
                    return item;
                });

                // Data Adapter untuk Transaksi
                var source = {
                    localdata: data,
                    datatype: "array",
                    datafields: [
                        { name: 'transNo', type: 'number' },
                        { name: 'itemCode', type: 'string' },
                        { name: 'transactionType', type: 'string' },
                        { name: 'transQty', type: 'number' },
                        { name: 'qtyBefore', type: 'number' },
                        { name: 'qtyAfter', type: 'number' },
                        { name: 'transDate', type: 'date' },
                        { name: 'userId', type: 'string' },
                        { name: 'picPickup', type: 'string' },
                        { name: 'deptPickup', type: 'string' }
                    ]
                };

                var dataAdapter = new $.jqx.dataAdapter(source);

                // Inisialisasi jqxGrid untuk Transaksi
                $("#jqxgrid").jqxGrid({
                    width: '100%',
                    height: 700,
                    source: dataAdapter,
                    pageable: true,
                    sortable: true,
                    columnsresize: true,
                    pagesize: 20,
		 		    pagesizeoptions: ['20', '50', '100'],
                    showfilterrow: true,
                    filterable: true,
                    enablebrowserselection: true,
                    keyboardnavigation: false,
                    columns: [
                        { 
                            text: "No", 
                            datafield: "id", 
                            width: 60, 
                            cellsrenderer: function (row, column, value, rowData, columnData) {
                                // Menggunakan row index untuk menghasilkan nomor urut
                                return '<div style="text-align: center; margin-top: 7px;">' + (row + 1) + '</div>';
                            } 
                        },           // Lebar untuk No
                        { text: 'Transaction No', datafield: 'transNo', width: '15%' },
                        { text: 'Item Code', datafield: 'itemCode', width: '15%' },
                        { text: 'Transaction Type', datafield: 'transactionType', width: '15%' },
                        { text: 'Quantity', datafield: 'transQty', width: '12%', cellsalign: 'right', align: 'center' },
                        { text: 'Qty Before', datafield: 'qtyBefore', width: '12%', cellsalign: 'right', align: 'center' },
                        { text: 'Qty After', datafield: 'qtyAfter', width: '12%', cellsalign: 'right', align: 'center' },
                        { text: 'Transaction Date', datafield: 'transDate', width: '12%', cellsformat: 'dd-MM-yyyy HH:mm' },
                        { text: 'User', datafield: 'userId', width: '12%' },
                        { text: 'PIC Pickup', datafield: 'picPickup', width: '12%' },
                        { text: 'Dept Pickup', datafield: 'deptPickup', width: '12%' },
                    ]
                });

                // Event listener untuk pemilihan baris
                $('#jqxgrid').on('rowselect', function (event) {
                    var rowsSelected = $("#jqxgrid").jqxGrid('getselectedrowindexes');
                    if (rowsSelected.length > 1) {
                        // Batalkan seleksi sebelumnya jika lebih dari satu baris dipilih
                        $("#jqxgrid").jqxGrid('unselectrow', rowsSelected[0]);
                    }

                    // Enable tombol edit jika satu baris terpilih
                    $('#editTransaction').prop('disabled', rowsSelected.length === 0);
                });
            },
            error: function() {
                alert('Failed to load transaction data.');
            }
        });

        // Event listener untuk tombol search
        $("#searchBtn").on("click", function() {
            const itemCode = $("#itemCodeFilter").val();
            const dateRange = $("#dateFilter").val();
            const queryParams = {};

            if (itemCode) queryParams.itemCode = itemCode;
            if (transDate) queryParams.transDate = transDate;

            // Mengambil data dengan filter menggunakan queryParams
            $.ajax({
                url: '/transactions/all', // Ganti dengan endpoint transaksi Anda
                type: 'GET',
                data: queryParams,
                success: function(data) {
                    // Update jqxGrid dengan data baru
                    const source = {
                        localdata: data,
                        datatype: "array",
                        datafields: [
                            { name: 'transNo', type: 'number' },
                            { name: 'itemCode', type: 'string' },
                            { name: 'transactionType', type: 'string' },
                            { name: 'transQty', type: 'number' },
                            { name: 'qtyBefore', type: 'number' },
                            { name: 'qtyAfter', type: 'number' },
                            { name: 'transDate', type: 'date' },
                            { name: 'userId', type: 'string' },
                            { name: 'picPickup', type: 'string' },
                            { name: 'deptPickup', type: 'string' }
                        ]
                    };

                    const dataAdapter = new $.jqx.dataAdapter(source);
                    $("#jqxgrid").jqxGrid({ source: dataAdapter });
                },
                error: function(err) {
                    console.error('Error fetching filtered transactions:', err);
                }
            });
        });

        // Event listener untuk tombol Export to Excel
        $("#excelBtn").on("click", function() {
            $("#jqxgrid").jqxGrid('exportdata', 'xls', 'Transactions_Report');
        });
    });
</script>
