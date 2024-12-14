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
                <!-- <a href="#" class="btn btn-primary mr-2" id="addBtn">Add</a> -->
                <a href="#" class="btn btn-danger" id="adjustBtn">Adjust</a>
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
                            <div class="input-group">
                                <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="far fa-calendar-alt"></i>
                                </span>
                                </div>
                                <!-- Input Rentang Tanggal -->
                                <input type="text" class="form-control float-right" id="daterangeForm" placeholder="Select Date Range">
                            </div>
                            <!-- /.input group -->
                    </div>
                    <div class="col-md-3">
                        <!-- Tombol Search -->
                        <button class="btn btn-success" id="searchBtn">Search</button>
                    </div>
                    <div class="col-md-3">
                        <!-- Tombol Excel -->
                        <button class="btn btn-info" id="excelhBtnAdjust">Excel</button>
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

<!-- Modal Adjust -->
<div class="modal fade" id="adjustModal" role="dialog" aria-labelledby="adjustModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="adjustForm" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="adjustModalLabel">Adjust Stock</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Form adjust -->
                    <div class="form-group">
                        <label for="adjustMaterialCode">Material Code</label>
                        <select class="form-control select2" id="adjustMaterialCode" style="width: 100%;" name="adjustMaterialCode" required>
                            <option value="" selected>Select Material Code</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="adjustDescription">Description</label>
                        <input type="text" class="form-control" id="adjustDescription" name="adjustDescription" placeholder="Enter Description" required>
                    </div>
                    <div class="form-group">
                        <label for="adjustPartNumber">Part Number</label>
                        <input type="text" class="form-control" id="adjustPartNumber" name="adjustPartNumber" placeholder="Enter Part Number" required>
                    </div>
                    <div class="form-group">
                        <label for="adjustUnit">Unit</label>
                        <select class="form-control select2" id="adjustUnit" style="width: 100%;" name="adjustUnit" required>
                            <option value="" selected>Select Unit</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="adjustRackLocation">Rack Location</label>
                        <select class="form-control select2" id="adjustRackLocation" style="width: 100%;" name="adjustRackLocation" required>
                            <option value="" selected>Select Location</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="adjustQuantity">Quantity</label>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" id="adjustQuantity" name="adjustQuantity" required>
                            <div class="input-group-append">
                              <span class="input-group-text" id="currentStockDisplay">Current Stock : 0</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-danger" onclick="updateStock()">Out Item</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- Script untuk menginisialisasi DataTables -->
<!-- <script src="${pageContext.request.contextPath}/static/plugins/jquery/jquery.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">

    // Fungsi untuk mengambil lokasi dari API dan mengisi dropdown
    function loadLocations() {
    fetch('/master/api/locations')
        .then(response => response.json())
        .then(data => {
            const locationFilter = document.getElementById('locationFilter');
            // Hapus semua option selain default
            locationFilter.innerHTML = '<option value="">Select Location</option>';
            
            // Loop melalui data lokasi dan menambahkannya ke dropdown
            data.forEach(location => {
                const option = document.createElement('option');
                option.value = location.locCd;  // Value untuk option adalah locCd
                option.textContent = location.location;  // Teks yang ditampilkan adalah nama lokasi
                locationFilter.appendChild(option);
            });
        })
        .catch(error => {
            console.error('Error fetching locations:', error);
        });
    }

    function updateStock() {
        const stockData = {
            itemCode: $('#adjustMaterialCode').val(),
            description: $('#adjustDescription').val(),
            partNum: $('#adjustPartNumber').val(),
            unitCd: $('#adjustUnit').val(),
            location: {
                locCd: $('#adjustRackLocation').val() // Gunakan locCd yang sesuai
            },
            transQty: $('#adjustQuantity').val(),
            department: $('#adjustDepartment').val(),
            pic: $('#adjustPic').val()
        };

        // Menentukan transactionType berdasarkan halaman aktif
        if (window.location.pathname.includes('/stock/adjustment')) {
            stockData.transactionType = 'adjustment'; // Jika di stock.jsp
        } else if (window.location.pathname.includes('/stock')) {
            stockData.transactionType = 'outbound'; // Jika di stock-adjustment.jsp
        }

        console.log("Data JSON yang dikirim:", stockData);
        console.log("Transaction Type:", stockData.transactionType);
        console.log("Current Page Path:", window.location.pathname);

        // Menampilkan setiap variabel di console
        console.log("Material Code:", stockData.itemCode);
        console.log("Description:", stockData.description);
        console.log("Part Number:", stockData.partNum);
        console.log("Unit:", stockData.unitCd);
        console.log("Rack Location:", stockData.location);
        console.log("Quantity:", stockData.transQty);
        console.log("Department Pickup:", stockData.department);
        console.log("PIC Pickup:", stockData.pic);

        $.ajax({
            url: '/transactions/outbound', // Ganti dengan endpoint yang sesuai untuk Outbound Stock
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(stockData),
            success: function (response) {
                console.log("Response from backend:", response);
                Swal.fire({
                    icon: 'success',
                    title: 'Stock berhasil dikeluarkan!',
                    showConfirmButton: false,
                    timer: 2000
                });
                // Reset form setelah submit sukses
                $('#adjustForm')[0].reset();
                $('#adjustModal').modal('hide'); // Menutup modal setelah sukses
                handleStockDataResponse('/transactions/adjust', '#jqxgrid', stockColumns); // Memperbarui grid stock setelah update
            },
            error: function (err) {
                console.error("Error updating stock:", err);
                Swal.fire({
                    icon: 'error',
                    title: 'Gagal!',
                    text: 'Terjadi kesalahan saat mengupdate data.',
                    showConfirmButton: true
                });
            }
        });
    }

    var stockColumns = [
        {
            text: "No",
            datafield: "id",
            width: '3%',
            align: 'center',
            cellsrenderer: function (row, column, value) {
                // Menggunakan row index untuk menghasilkan nomor urut
                return '<div style="text-align: center; margin-top: 7px;">' + (row + 1) + '</div>';
            }
        },
        { text: "Transaction No", datafield: "transNo", width: '11%', align: 'center' },
        { text: "Item Code", datafield: "itemCode", width: '17%', align: 'center' },
        { text: "Transaction Type", datafield: "transactionType", width: '11%', align: 'center' },
        { text: "Quantity", datafield: "transQty", width: '7%', cellsalign: 'right', align: 'center', align: 'center' },
        { text: "Qty Before", datafield: "qtyBefore", width: '7%', cellsalign: 'right', align: 'center', align: 'center' },
        { text: "Qty After", datafield: "qtyAfter", width: '7%', cellsalign: 'right', align: 'center', align: 'center' },
        { text: "Transaction Date", datafield: "transDate", width: '12%', cellsformat: 'dd-MM-yyyy HH:mm', align: 'center' },
        { text: "User", datafield: "userId", width: '10%', hidden:true, align: 'center'  },
        { text: "PIC Pickup", datafield: "picPickup", width: '12%', align: 'center' },
        { text: "Dept Pickup", datafield: "deptPickup", width: '12%', align: 'center' },
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
            showfilterrow: true,
            filterable: true,
            sortable: true,
            // selectionmode: 'checkbox',
            columns: columns
        });
    }

    function handleStockDataResponse(url, gridId, columns) {
        $.ajax({
            url: url,
            method: 'GET',
            success: function (data) {
                // Process data
                const stockData = data.map((item, index) => ({
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

                // Data Adapter
                const source = {
                    localdata: stockData,
                    datatype: "array",
                    datafields: columns.map(col => ({ name: col.datafield, type: 'string' }))
                };

                const dataAdapter = new $.jqx.dataAdapter(source);

                // Initialize jqxGrid with dataAdapter
                initializeGrid(gridId, columns, dataAdapter);
            },
            error: function (err) {
                console.log('Error fetching data from API', err);
            }
        });
    }

    $(document).ready(function () {

        $('#adjustMaterialCode, #adjustRackLocation').change(function() {
            // Ambil nilai dari dropdown
            let itemCode = $('#adjustMaterialCode').val();
            let location = $('#adjustRackLocation').val();

            // Cek apakah kedua dropdown sudah terisi
            if (itemCode && location) {
                // Lakukan AJAX request jika kedua dropdown terisi
                $.ajax({
                    url: '/stock/current', // URL controller untuk mendapatkan data
                    type: 'GET',
                    data: {
                        itemCode: itemCode,
                        location: location
                    },
                    success: function(response) {
                        console.log('hasil respone current', response);
                        console.log(response.currentQty);
                        if (response && response.currentQty !== undefined) {
                            $('#currentStockDisplay').text('Current Stock: ' + response.currentQty);
                        } else {
                            $('#currentStockDisplay').text('No stock data available');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error fetching stock:', error);
                        $('#currentStockDisplay').text('Failed to fetch stock');
                    }
                });
            } else {
                console.log('Please select both Material Code and Rack Location.');
            }
        });

        // Inisialisasi select2
        $('.select2').select2();

        // Memuat lokasi untuk dropdown
        loadLocations();

        // Fungsi untuk memuat data stok dan menginisialisasi grid
        handleStockDataResponse('/transactions/adjust', '#jqxgrid', stockColumns);

        // Menampilkan modal adjust
        $("#adjustBtn").on("click", function () {
            $("#adjustModal").modal("show");
        });

        // Mengambil data untuk Material Codes
        $.ajax({
            url: '${pageContext.request.contextPath}/master/api/items',
            type: 'GET',
            success: function (data) {
                let materialCodeDropdownEdit = $('#adjustMaterialCode');  // Untuk modal adjust

                data.forEach(function (item) {
                    // Gabungkan itemCode dan itemName dengan tanda hubung
                    materialCodeDropdownEdit.append('<option value="' + item.itemCode + '">' + item.itemCode + ' - ' + item.itemName + '</option>');
                });
            },
            error: function (err) {
                console.error("Error fetching material codes:", err);
            }
        });

        // Mengambil data Unit
        $.ajax({
            url: '${pageContext.request.contextPath}/master/api/units',
            type: 'GET',
            success: function (data) {
                let unitDropdownEdit = $('#adjustUnit');  // Untuk modal adjust

                data.forEach(function (unit) {
                    unitDropdownEdit.append('<option value="' + unit.unitCd + '">' + unit.unitCd + ' - ' + unit.description + '</option>');
                });
            },
            error: function (err) {
                console.error("Error fetching units:", err);
            }
        });

        // Mengambil data Rack Locations
        $.ajax({
            url: '${pageContext.request.contextPath}/master/api/locations',
            type: 'GET',
            success: function (data) {
                let rackLocationDropdownEdit = $('#adjustRackLocation');  // Untuk modal adjust

                data.forEach(function (location) {
                    rackLocationDropdownEdit.append('<option value="' + location.locCd + '">' + location.locCd + ' - ' + location.location + '</option>');
                });
            },
            error: function (err) {
                console.error("Error fetching locations:", err);
            }
        });

        // Menggunakan Select2 di dalam modal adjust
        $('#adjustModal').on('shown.bs.modal', function () {
            $('.select2').select2();  // Inisialisasi Select2 pada modal adjust
        });

        // Event listener untuk materialCode di modal adjust
        $('#adjustMaterialCode').on('change', function () {
            var selectedItemCode = $(this).val();
            console.log('selectedItemCode', selectedItemCode);

            if (selectedItemCode) {
                // Ambil data dari server berdasarkan itemCode
                $.ajax({
                    url: '${pageContext.request.contextPath}/master/api/get-item-details',  // Ganti dengan endpoint yang sesuai
                    type: 'GET',
                    contentType: 'application/json',
                    accept: 'application/json', 
                    data: { itemCode: selectedItemCode },
                    success: function (response) {
                        console.log('hasil response', response);
                        if (response) {
                            // Isi field Description dan Part Number untuk modal adjust
                            $('#adjustDescription').val(response.description);
                            $('#adjustPartNumber').val(response.partNumber);
                        } else {
                            // Jika data tidak ditemukan
                            $('#adjustDescription').val('');
                            $('#adjustPartNumber').val('');
                            Swal.fire('Error', 'Material code not found', 'error');
                        }
                    },
                    error: function () {
                        Swal.fire('Error', 'Failed to fetch data from server', 'error');
                    }
                });
            } else {
                // Kosongkan field jika tidak ada itemCode yang dipilih
                $('#adjustDescription').val('');
                $('#adjustPartNumber').val('');
            }
        });

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

        // Event listener untuk search button
        $("#searchBtn").on("click", function() {
            const itemCodeFilter = $("#itemCodeFilter").val(); // Ambil nilai filter Item Code
            const dateRange = $('#daterangeForm').val(); // Ambil nilai filter Date Range
            let startDate = null, endDate = null;

            if (dateRange) {
                const dates = dateRange.split(" - "); // Memisahkan rentang tanggal menjadi start dan end date
                startDate = dates[0]; // Tanggal awal
                endDate = dates[1]; // Tanggal akhir
            }

            // Kirim request dengan parameter yang ada (filter yang dipilih)
            $.ajax({
                url: '/transactions/adjust',
                type: 'GET',
                data: {
                    itemCode: itemCodeFilter || undefined, // Kirim itemCode jika ada, jika tidak undefined
                    startDate: startDate || undefined,     // Kirim startDate jika ada, jika tidak undefined
                    endDate: endDate || undefined          // Kirim endDate jika ada, jika tidak undefined
                },
                success: function(data) {
                    console.log('Filtered Stock Data:', data);

                    const stockData = data.map((item, index) => ({
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

                    const source = {
                        localdata: stockData,
                        datatype: "array",
                        datafields: [
                            { name: "transNo", type: "string" },
                            { name: "itemCode", type: "string" },
                            { name: "transactionType", type: "string" },
                            { name: "transQty", type: "number" },
                            { name: "qtyBefore", type: "number" },
                            { name: "qtyAfter", type: "number" },
                            { name: "transDate", type: "string" },
                            { name: "userId", type: "string" },
                            { name: "picPickup", type: "string" },
                            { name: "deptPickup", type: "string" }
                        ]
                    };

                    const dataAdapter = new $.jqx.dataAdapter(source);

                    $("#jqxgrid").jqxGrid({
                        width: '100%',
                        height: 600,
                        source: dataAdapter,
                        autoheight: false,
                        pageable: true,
                        sortable: true,
                        pagesize: 10,
                        columnsresize: true,
                        showcolumnlines: true,
                        showcolumnheaderlines: true,
                        showtoolbar: true,
                        pagerMode: 'default',
                        columns: stockColumns
                    });
                },
                error: function(err) {
                    console.log('Error fetching filtered data from API', err);
                }
            });
        });

        // Event listener untuk tombol Excel
        $("#excelhBtnAdjust").on("click", function() {
            // Mendapatkan nilai filter
            var dateRange = $('#daterangeForm').val();
            var itemCode = $('#itemCodeFilter').val();
            var startDate = '';
            var endDate = '';

            if (dateRange) {
                var dates = dateRange.split(" - ");
                startDate = formatDate(dates[0]);  // Mengubah tanggal menjadi format yyyy-MM-dd
                endDate = formatDate(dates[1]);    // Mengubah tanggal menjadi format yyyy-MM-dd
            }

            console.log(itemCode);
            console.log(startDate);
            console.log(endDate);

            // Menggunakan AJAX untuk permintaan GET untuk export Excel
            $.ajax({
                url: `/transactions/api/export-excel-adjust`,  // URL endpoint baru
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
                    a.download = 'stock_adjustment_transactions.xlsx'; // Nama file yang akan diunduh
                    a.click();
                    window.URL.revokeObjectURL(url); // Hapus URL setelah download
                },
                error: function(xhr, status, error) {
                    console.error('Error downloading Excel:', error);
                }
            });
        });

        // Fungsi untuk mengubah tanggal ke format yyyy-MM-dd
        function formatDate(dateString) {
            var date = new Date(dateString);
            var day = ("0" + date.getDate()).slice(-2);  // Tambahkan leading zero jika tanggal hanya satu digit
            var month = ("0" + (date.getMonth() + 1)).slice(-2); // Bulan dimulai dari 0, tambahkan 1
            var year = date.getFullYear();
            return year + '-' + month + '-' + day;
        }
    });

</script>