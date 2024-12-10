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
                        <!-- Dropdown Location -->
                        <select id="locationFilter" class="form-control">
                            <option value="">Select Location</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <!-- Tombol Search -->
                        <button class="btn btn-success" id="searchBtn">Search</button>
                    </div>
                    <div class="col-md-3">
                        <!-- Tombol Excel -->
                        <button class="btn btn-info" id="excelhBtn">Excel</button>
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
                        <input type="text" class="form-control" id="adjustQuantity" name="adjustQuantity" required>
                    </div>
                    <!-- <div class="form-group">
                        <label for="adjustDepartment">Department Pickup</label>
                        <input type="text" class="form-control" id="adjustDepartment" name="adjustDepartment" required>
                    </div>
                    <div class="form-group">
                        <label for="adjustPic">PIC Pickup</label>
                        <input type="text" class="form-control" id="adjustPic" name="adjustPic" required>
                    </div> -->
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
            cellsrenderer: function (row, column, value) {
                // Menggunakan row index untuk menghasilkan nomor urut
                return '<div style="text-align: center; margin-top: 7px;">' + (row + 1) + '</div>';
            }
        },
        { text: "Transaction No", datafield: "transNo", width: '15%' },
        { text: "Item Code", datafield: "itemCode", width: '15%' },
        { text: "Transaction Type", datafield: "transactionType", width: '15%' },
        { text: "Quantity", datafield: "transQty", width: '12%', cellsalign: 'right', align: 'center' },
        { text: "Qty Before", datafield: "qtyBefore", width: '12%', cellsalign: 'right', align: 'center' },
        { text: "Qty After", datafield: "qtyAfter", width: '12%', cellsalign: 'right', align: 'center' },
        { text: "Transaction Date", datafield: "transDate", width: '12%', cellsformat: 'dd-MM-yyyy HH:mm' },
        { text: "User", datafield: "userId", width: '12%' },
        { text: "PIC Pickup", datafield: "picPickup", width: '12%' },
        { text: "Dept Pickup", datafield: "deptPickup", width: '12%' },
    ];

    function initializeGrid(gridId, columns, dataAdapter) {
        $(gridId).jqxGrid({
            width: '100%',
            height: 700,  /* Mengatur tinggi grid */
            autoheight: false,  /* Nonaktifkan autoheight */
            pageable: true,
            pagesize: 10, // Show 10 rows per page
            source: dataAdapter,
            columnsresize: true,
            pagerMode: 'default',
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

        // Event listener untuk search button
        $("#searchBtn").on("click", function() {
            const itemCodeFilter = $("#itemCodeFilter").val(); // Ambil nilai filter Item Code
            const locationFilter = $("#locationFilter").val(); // Ambil nilai filter Location

            console.log('ItemCodeFilter : ', itemCodeFilter);
            console.log('locationFilter : ', locationFilter);

            $.ajax({
                url: '/stock/api/filter',
                type: 'GET',
                data: {
                    itemCode: itemCodeFilter,
                    location: locationFilter
                },
                success: function(data) {
                    console.log('Filtered Stock Data:', data);

                    const stockData = data.map((item, index) => ({
                        transNo: item.transNo,
                        itemCode: item.itemCode, // Assuming itemCode is the 'Material'
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
                        height: 430,
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

    });

</script>