
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
                        <input type="text" class="form-control" id="description" name="description" placeholder="Enter Description" required>
                    </div>
                    <div class="form-group">
                        <label for="partNumber">Part Number</label>
                        <input type="text" class="form-control" id="partNumber" name="partNumber" placeholder="Enter Part Number" required>
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
                    <h5 class="modal-title" id="editModalLabel">Edit Stock</h5>
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


    $(document).ready(function () {
        $('.select2').select2();
        loadLocations();

        // Mengambil data dari API menggunakan AJAX
        $.ajax({
            url: '/stock/api',  // URL API untuk mendapatkan semua stok
            type: 'GET',
            success: function(data) {
                // Data yang diterima dari API
                console.log('Hasil all stock : ', data);
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

                // Sumber data untuk jqxGrid
                const source = {
                    localdata: stockData,
                    datatype: "array",
                    datafields: [
                        { name: "id", type: "number" },            // No
                        { name: "material", type: "string" },       // Material
                        { name: "materialName", type: "string" },       // Material
                        { name: "description", type: "string" },    // Description
                        { name: "partNumber", type: "number" },     // Part Number
                        { name: "baseUnit", type: "string" },       // Base Unit
                        { name: "storageLocation", type: "string" }, // Storage Location
                        { name: "quantity", type: "string" }, // Quantity
                        { name: "safetyStock", type: "string" } // Safety Stock
                    ]
                };

                const dataAdapter = new $.jqx.dataAdapter(source);

                // Inisialisasi jqxGrid dengan data dari API
                $("#jqxgrid").jqxGrid({
                    width: '100%',
                    height: 430,
                    source: dataAdapter,
                    autoheight: false,
                    pageable: true,
                    sortable: true,
                    pagesize: 10, // Show 10 rows per page
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
                                // Menggunakan row index untuk menghasilkan nomor urut
                                return '<div style="text-align: center; margin-top: 7px;">' + (row + 1) + '</div>';
                            } 
                        },           // Lebar untuk No
                        { text: "Material", datafield: "material", width: 150 },  // Lebar untuk Material
                        { text: "Material Name", datafield: "materialName", width: 150 },  // Lebar untuk Material
                        { text: "Description", datafield: "description", width: 180 },  // Lebar untuk Description
                        { text: "Part Number", datafield: "partNumber", width: 100, cellsalign: 'center', align: 'center' }, // Lebar untuk Part Number
                        { text: "Base Unit", datafield: "baseUnit", width: 120 },    // Lebar untuk Base Unit
                        { text: "Storage Location", datafield: "storageLocation", width: 150 }, // Lebar untuk Storage Location
                        { text: "Quantity", datafield: "quantity", width: 150 }, // Lebar untuk Storage Location
                        { text: "Safety Stock", datafield: "safetyStock", width: 150 } // Lebar untuk Storage Location
                    ]
                });
            },
            error: function(err) {
                console.log('Error fetching data from API', err);
            }
        });

        $("#addBtn").on("click", function () {
            $("#addModal").modal("show");
        });

        // Menampilkan modal Edit dan menginisialisasi Select2 di dalamnya
        $("#outBtn").on("click", function () {
            $("#editModal").modal("show");
        });

        $.ajax({
            url: '${pageContext.request.contextPath}/master/api/items',
            type: 'GET',
            success: function (data) {
                let materialCodeDropdown = $('#materialCode');
                data.forEach(function (item) {
                    // Gabungkan itemCode dan itemName dengan tanda hubung
                    materialCodeDropdown.append('<option value="' + item.itemCode + '">' + item.itemCode + ' - ' + item.itemName + '</option>');
                });
            },
            error: function (err) {
                console.error("Error fetching material codes:", err);
            }
        });

        // AJAX untuk mengambil data Unit
        $.ajax({
            url: '${pageContext.request.contextPath}/master/api/units',
            type: 'GET',
            success: function (data) {
                let unitDropdown = $('#unit');
                data.forEach(function (unit) {
                    unitDropdown.append('<option value="' + unit.unitCd + '">' + unit.unitCd + ' - ' + unit.description + '</option>');
                });
            },
            error: function (err) {
                console.error("Error fetching rack locations:", err);
            }
        });

        // AJAX untuk mengambil data Rack Location
        $.ajax({
            url: '${pageContext.request.contextPath}/master/api/locations',
            type: 'GET',
            success: function (data) {
                let rackLocationDropdown = $('#rackLocation');
                data.forEach(function (location) {
                    rackLocationDropdown.append('<option value="' + location.locCd + '">' + location.locCd + ' - ' + location.location + '</option>');
                });
            },
            error: function (err) {
                console.error("Error fetching rack locations:", err);
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