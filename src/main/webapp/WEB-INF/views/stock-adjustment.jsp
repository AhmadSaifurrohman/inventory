
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
                <a href="#" class="btn btn-primary mr-2" id="addBtn">Add</a>
                <a href="#" class="btn btn-danger" id="outBtn">Out</a>
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

<!-- Modal Add -->
<div class="modal fade" id="addModal" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="addForm" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">Add Stock</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Form Add -->
                    <div class="form-group">
                        <label for="materialCode">Material Code</label>
                        <select class="form-control select2" id="materialCode" style="width: 100%;" name="materialCode" required>
                            <option value="" selected>Select Material Code</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <input type="text" class="form-control" id="description" name="description" placeholder="Enter Description" disabled required>
                    </div>
                    <div class="form-group">
                        <label for="partNumber">Part Number</label>
                        <input type="text" class="form-control" id="partNumber" name="partNumber" placeholder="Enter Part Number" disabled required>
                    </div>
                    <div class="form-group">
                        <label for="unit">Unit</label>
                        <select class="form-control select2" id="unit" style="width: 100%;" name="unit" required>
                            <option value="" selected>Select Unit</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="rackLocation">Rack Location</label>
                        <select class="form-control select2" id="rackLocation" style="width: 100%;" name="rackLocation" required>
                            <option value="" selected>Select Location</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="quantity">Quantity</label>
                        <input type="text" class="form-control" id="quantity" name="quantity" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="saveStock()">Add Item</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- Modal Edit -->
<div class="modal fade" id="editModal" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="editForm" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Out Stock</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Form Edit -->
                    <div class="form-group">
                        <label for="editMaterialCode">Material Code</label>
                        <select class="form-control select2" id="editMaterialCode" style="width: 100%;" name="editMaterialCode" required>
                            <option value="" selected>Select Material Code</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editDescription">Description</label>
                        <input type="text" class="form-control" id="editDescription" name="editDescription" placeholder="Enter Description" required>
                    </div>
                    <div class="form-group">
                        <label for="editPartNumber">Part Number</label>
                        <input type="text" class="form-control" id="editPartNumber" name="editPartNumber" placeholder="Enter Part Number" required>
                    </div>
                    <div class="form-group">
                        <label for="editUnit">Unit</label>
                        <select class="form-control select2" id="editUnit" style="width: 100%;" name="editUnit" required>
                            <option value="" selected>Select Unit</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editRackLocation">Rack Location</label>
                        <select class="form-control select2" id="editRackLocation" style="width: 100%;" name="editRackLocation" required>
                            <option value="" selected>Select Location</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editQuantity">Quantity</label>
                        <input type="text" class="form-control" id="editQuantity" name="editQuantity" required>
                    </div>
                    <div class="form-group">
                        <label for="editDepartment">Department Pickup</label>
                        <input type="text" class="form-control" id="editDepartment" name="editDepartment" required>
                    </div>
                    <div class="form-group">
                        <label for="editPic">PIC Pickup</label>
                        <input type="text" class="form-control" id="editPic" name="editPic" required>
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

    // Function to save stock via AJAX
    function saveStock() {
        const quantity = $('#quantity').val();
        console.log("Type of quantity: " + typeof quantity);
        const stockData = {
            itemCode: $('#materialCode').val(),
            description: $('#description').val(),
            partNum: $('#partNumber').val(),
            unitCd: $('#unit').val(),
            location: {
                locCd: $('#rackLocation').val() // Gunakan locCd yang sesuai
            },
            transQty: $('#quantity').val()
        };

        console.log("Data JSON yang dikirim:", stockData);

        // Menampilkan setiap variabel di console
        console.log("Material Code:", stockData.itemCode);
        console.log("Description:", stockData.description);
        console.log("Part Number:", stockData.partNum);
        console.log("Unit:", stockData.unitCd);
        console.log("Rack Location:", stockData.location);
        console.log("Quantity:", stockData.transQty);

        $.ajax({
            url: '/transactions/inbound', // Mengubah endpoint ke transactions/inbound
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(stockData),
            success: function (response) {
                Swal.fire({
                    icon: 'success',
                    title: 'Stock berhasil ditambahkan!',
                    showConfirmButton: false,
                    timer: 2000
                });
                // Reset form setelah submit sukses
                $('#addForm')[0].reset();
                $('#addModal').modal('hide'); // Menutup modal setelah sukses
                handleStockDataResponse('/stock/api', '#jqxgrid', stockColumns);
            },
            error: function (err) {
                console.error("Error saving stock:", err);
                Swal.fire({
                    icon: 'error',
                    title: 'Gagal!',
                    text: 'Terjadi kesalahan saat menyimpan data.',
                    showConfirmButton: true
                });
            }
        });
    }

    function updateStock() {
        const stockData = {
            itemCode: $('#editMaterialCode').val(),
            description: $('#editDescription').val(),
            partNum: $('#editPartNumber').val(),
            unitCd: $('#editUnit').val(),
            location: {
                locCd: $('#editRackLocation').val() // Gunakan locCd yang sesuai
            },
            transQty: $('#editQuantity').val(),
            department: $('#editDepartment').val(),
            pic: $('#editPic').val()
        };

        console.log("Data JSON yang dikirim:", stockData);

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
                $('#editForm')[0].reset();
                $('#editModal').modal('hide'); // Menutup modal setelah sukses
                handleStockDataResponse('/stock/api', '#jqxgrid', stockColumns); // Memperbarui grid stock setelah update
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
            { text: "Material", datafield: "material", width: '7%', cellsalign: 'center', align: 'center' },
            { text: "Material Name", datafield: "materialName", width: '15%', cellsalign: 'left', align: 'center' },
            { text: "Description", datafield: "description", width: '30%', cellsalign: 'left', align: 'center' },
            { text: "Part Number", datafield: "partNumber", width: '15%', cellsalign: 'center', align: 'center' },
            { text: "Base Unit", datafield: "baseUnit", width: '10%', cellsalign: 'center', align: 'center' },
            { text: "Storage Location", datafield: "storageLocation", width: '10%', cellsalign: 'center', align: 'center' },
            { text: "Quantity", datafield: "quantity", width: '5%', cellsalign: 'center', align: 'center' },
            { text: "Safety Stock", datafield: "safetyStock", width: '5%' , cellsalign: 'center', align: 'center'}
        ];

    function initializeGrid(gridId, columns, dataAdapter) {
            $(gridId).jqxGrid({
                width: '100%',
                height: 350,  /* Mengatur tinggi grid */
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

    // Function to handle data response and initialize grid
    function handleStockDataResponse(url, gridId, columns) {
        $.ajax({
            url: url,
            method: 'GET',
            success: function (data) {
                // Process data
                const stockData = data.map((item, index) => ({
                    id: index + 1, // Nomor urut berdasarkan index
                    material: item.itemCode,
                    materialName: item.itemName,
                    description: item.itemDescription,
                    partNumber: item.partNum,
                    baseUnit: item.unitCd,
                    storageLocation: item.locationName,
                    quantity: item.quantity,
                    safetyStock: item.safetyStock
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
        loadLocations();

        // Fungsi untuk memuat data stok dan menginisialisasi grid
        handleStockDataResponse('/stock/api', '#jqxgrid', stockColumns);

        // Menampilkan modal Add
        $("#addBtn").on("click", function () {
            $("#addModal").modal("show");
        });

        // Menampilkan modal Edit
        $("#outBtn").on("click", function () {
            $("#editModal").modal("show");
        });

        // Mengambil data untuk Material Codes
        $.ajax({
            url: '${pageContext.request.contextPath}/master/api/items',
            type: 'GET',
            success: function (data) {
                let materialCodeDropdownAdd = $('#materialCode');  // Untuk modal Add
                let materialCodeDropdownEdit = $('#editMaterialCode');  // Untuk modal Edit

                data.forEach(function (item) {
                    // Gabungkan itemCode dan itemName dengan tanda hubung
                    materialCodeDropdownAdd.append('<option value="' + item.itemCode + '">' + item.itemCode + ' - ' + item.itemName + '</option>');
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
                let unitDropdownAdd = $('#unit');  // Untuk modal Add
                let unitDropdownEdit = $('#editUnit');  // Untuk modal Edit

                data.forEach(function (unit) {
                    unitDropdownAdd.append('<option value="' + unit.unitCd + '">' + unit.unitCd + ' - ' + unit.description + '</option>');
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
                let rackLocationDropdownAdd = $('#rackLocation');  // Untuk modal Add
                let rackLocationDropdownEdit = $('#editRackLocation');  // Untuk modal Edit

                data.forEach(function (location) {
                    rackLocationDropdownAdd.append('<option value="' + location.locCd + '">' + location.locCd + ' - ' + location.location + '</option>');
                    rackLocationDropdownEdit.append('<option value="' + location.locCd + '">' + location.locCd + ' - ' + location.location + '</option>');
                });
            },
            error: function (err) {
                console.error("Error fetching locations:", err);
            }
        });

        // Menggunakan Select2 di dalam modal Edit dan Add
        $('#editModal').on('shown.bs.modal', function () {
            $('.select2').select2();  // Inisialisasi Select2 pada modal Edit
        });

        $('#addModal').on('shown.bs.modal', function () {
            $('.select2').select2();  // Inisialisasi Select2 pada modal Add
        });
    });

    $(document).ready(function () {
        // Event listener untuk materialCode di modal Add dan Edit
        $('#materialCode, #editMaterialCode').on('change', function () {
            var selectedItemCode = $(this).val();
            console.log('selectedItemCode', selectedItemCode);
            
            // Tentukan apakah yang dipilih adalah dropdown modal Add atau Edit
            var targetModal = $(this).closest('.modal').attr('id'); // Mengetahui modal yang aktif (addModal atau editModal)
            
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
                            // Isi field Description dan Part Number untuk modal yang aktif
                            if (targetModal === 'addModal') {
                                $('#description').val(response.description);
                                $('#partNumber').val(response.partNumber);
                            } else if (targetModal === 'editModal') {
                                $('#editDescription').val(response.description);
                                $('#editPartNumber').val(response.partNumber);
                            }
                        } else {
                            // Jika data tidak ditemukan
                            if (targetModal === 'addModal') {
                                $('#description').val('');
                                $('#partNumber').val('');
                            } else if (targetModal === 'editModal') {
                                $('#editDescription').val('');
                                $('#editPartNumber').val('');
                            }
                            Swal.fire('Error', 'Material code not found', 'error');
                        }
                    },
                    error: function () {
                        Swal.fire('Error', 'Failed to fetch data from server', 'error');
                    }
                });
            } else {
                // Kosongkan field jika tidak ada itemCode yang dipilih
                if (targetModal === 'addModal') {
                    $('#description').val('');
                    $('#partNumber').val('');
                } else if (targetModal === 'editModal') {
                    $('#editDescription').val('');
                    $('#editPartNumber').val('');
                }
            }
        });
    });

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
                    id: item.id,
                    material: item.itemCode, // Assuming itemCode is the 'Material'
                    materialName: item.itemName, 
                    description: item.itemDescription,
                    partNumber: item.partNum,
                    baseUnit: item.unitCd,
                    storageLocation: item.locationName,
                    quantity: item.quantity,
                    safetyStock: item.safetyStock,
                    location: item.locationName
                }));

                const source = {
                    localdata: stockData,
                    datatype: "array",
                    datafields: [
                        { name: "id", type: "number" },
                        { name: "material", type: "string" },
                        { name: "materialName", type: "string" },
                        { name: "description", type: "string" },
                        { name: "partNumber", type: "number" },
                        { name: "baseUnit", type: "string" },
                        { name: "storageLocation", type: "string" },
                        { name: "quantity", type: "string" },
                        { name: "safetyStock", type: "string" }
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
                    columns: [
                        { 
                            text: "No", 
                            datafield: "id", 
                            width: 60, 
                            cellsrenderer: function (row, column, value, rowData, columnData) {
                                return '<div style="text-align: center; margin-top: 7px;">' + (row + 1) + '</div>';
                            }
                        },
                        { text: "Material", datafield: "material", width: 150 },
                        { text: "Material Name", datafield: "materialName", width: 150 },
                        { text: "Description", datafield: "description", width: 180 },
                        { text: "Part Number", datafield: "partNumber", width: 100, cellsalign: 'center', align: 'center' },
                        { text: "Base Unit", datafield: "baseUnit", width: 120 },
                        { text: "Storage Location", datafield: "storageLocation", width: 150 },
                        { text: "Quantity", datafield: "quantity", width: 150 },
                        { text: "Safety Stock", datafield: "safetyStock", width: 150 }
                    ]
                });
            },
            error: function(err) {
                console.log('Error fetching filtered data from API', err);
            }
        });
    });

</script>