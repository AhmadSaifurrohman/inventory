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
                                    <input type="text" class="form-control float-right" id="daterangeForm">
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
                            <button class="btn btn-info" id="excelBtn" onclick="downloadExcel()">Download Excel</button>
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

    var stockColumns = [
        { 
            text: "No", 
            datafield: "id", 
            width: 60,
            align: 'center',
            cellsrenderer: function (row, column, value, rowData, columnData) {
                // Menggunakan row index untuk menghasilkan nomor urut
                return '<div style="text-align: center; margin-top: 7px;">' + (row + 1) + '</div>';
            } 
        },           // Lebar untuk No
        { text: 'Transaction No', datafield: 'transNo', width: '11%', align: 'center' },
        { text: 'Item Code', datafield: 'itemCode', width: '17%', align: 'center' },
        { text: 'Transaction Type', datafield: 'transactionType', width: '11%', align: 'center' },
        { text: 'Quantity', datafield: 'transQty', width: '7%', cellsalign: 'right', align: 'center', align: 'center' },
        { text: 'Qty Before', datafield: 'qtyBefore', width: '7%', cellsalign: 'right', align: 'center', align: 'center' },
        { text: 'Qty After', datafield: 'qtyAfter', width: '7%', cellsalign: 'right', align: 'center', align: 'center' },
        { text: 'Transaction Date', datafield: 'transDate', width: '12%', cellsformat: 'dd-MM-yyyy HH:mm', align: 'center' },
        { text: 'User', datafield: 'userId', width: '10%', hidden:true, align: 'center' },
        { text: 'PIC Pickup', datafield: 'picPickup', width: '12%', align: 'center' },
        { text: 'Dept Pickup', datafield: 'deptPickup', width: '12%', align: 'center' },
    ];

    function initializeGrid(gridId, columns, dataAdapter) {
            $(gridId).jqxGrid({
                width: '100%',
                height: 600,  /* Mengatur tinggi grid */
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

    // Function to handle data response and initialize grid
    function handleStockDataResponse(url, gridId, columns, startDate, endDate, itemCode) {
        console.log(startDate, endDate, itemCode);
        let params = {};
        if (startDate && endDate) {
            params = { ...params, startDate: startDate, endDate: endDate };
        }
        if (itemCode) {
            params = { ...params, itemCode: itemCode };
        }

        // Lakukan AJAX request
        $.ajax({
            url: url,
            method: 'GET',
            data: params, // Hanya mengirim parameter jika ada
            success: function (data) {
                // console.log('Hasil data:', data);

                // Proses data untuk grid
                const stockData = data.map((item, index) => ({
                    id: index + 1, // Nomor urut berdasarkan index
                    transNo: item.transNo,
                    itemCode: item.itemCode,
                    transactionType: item.transactionType,
                    transQty: item.transQty,
                    qtyBefore: item.qtyBefore,
                    qtyAfter: item.qtyAfter,
                    transDate: item.transDate,
                    userId: item.userId,
                    picPickup: item.picPickup,
                    deptPickup: item.deptPickup
                }));

                // Siapkan data adapter untuk grid
                const source = {
                    localdata: stockData,
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

    // Fungsi untuk menangani klik tombol search
    $("#searchBtn").on("click", function() {
        var dateRange = $('#daterangeForm').val();
        var itemCode = $('#itemCodeFilter').val();
        var dates = dateRange.split(" - "); // Memisahkan rentang tanggal menjadi start dan end date

        var startDate = dates[0]; // Tanggal awal
        var endDate = dates[1]; // Tanggal akhir
      
        handleStockDataResponse('/transactions/all', '#jqxgrid', stockColumns, startDate, endDate, itemCode);
    });

    $(document).ready(function () {
        loadLocations();

        $('#daterangeForm').daterangepicker({
            locale: {
                format: 'YYYY-MM-DD' // Format tanggal yang dikirim ke server
            },
            autoUpdateInput: false,
        });

         // Mengupdate nilai input hanya saat rentang tanggal dipilih
        $('#daterangeForm').on('apply.daterangepicker', function (ev, picker) {
            $(this).val(picker.startDate.format('YYYY-MM-DD') + ' - ' + picker.endDate.format('YYYY-MM-DD'));
        });

        // Menghapus nilai input saat tombol Cancel diklik
        $('#daterangeForm').on('cancel.daterangepicker', function (ev, picker) {
            $(this).val('');
        });

        // Mengosongkan input jika pengguna menghapus nilai secara manual
        $('#daterangeForm').on('input', function () {
            if (!$(this).val()) {
                $(this).data('daterangepicker').setStartDate(moment()); // Reset ke default
                $(this).data('daterangepicker').setEndDate(moment());
            }
        });

        // Ambil data transaksi menggunakan AJAX
        handleStockDataResponse('/transactions/all', '#jqxgrid', stockColumns);
    });

    function downloadExcel() {
        // Mendapatkan nilai filter
        var dateRange = $('#daterangeForm').val();
        var itemCode = $('#itemCodeFilter').val();
        var dates = dateRange.split(" - "); 
        if (dateRange) {
            var dates = dateRange.split(" - "); 
            var startDate = dates[0];
            var endDate = dates[1];
        } else {
            var startDate = ''; 
            var endDate = '';   
        }

        console.log(itemCode);
        console.log(startDate);
        console.log(endDate);

        // Menggunakan AJAX untuk permintaan GET
        $.ajax({
            url: `/transactions/api/export-excel`,
            method: 'GET',
            xhrFields: {
                responseType: 'blob' // Mengatur response sebagai file blob
            },
            data: {
                itemCode: itemCode,
                startDate: startDate,
                endDate: endDate
            },
            success: function(blob) {
                // Membuat URL untuk blob dan memulai download
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = 'stock_transaction.xlsx'; // Nama file yang akan diunduh
                a.click();
                window.URL.revokeObjectURL(url); // Hapus URL setelah download
            },
            error: function(xhr, status, error) {
                console.error('Error downloading Excel:', error);
            }
        });
    }
     
</script>
