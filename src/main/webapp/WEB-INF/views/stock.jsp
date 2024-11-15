<h1 class="m-0">Stock List</h1>
<!-- <p class="lead">Berikut adalah daftar stok barang di gudang.</p> -->

<!-- Tabel menggunakan AdminLTE -->
<div class="card">
    <div class="card-header">
        <div class="d-flex justify-content-between w-100">
            <a href="${pageContext.request.contextPath}/stock/add-stock" class="btn btn-primary" id="addBtn">Add</a>
            <!-- <h3 class="card-title">Stock List</h3> -->
            <!-- Form untuk Filter dan Search -->
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


<!-- Script untuk menginisialisasi DataTables -->
<script src="${pageContext.request.contextPath}/static/plugins/jquery/jquery.min.js"></script>
<script type="text/javascript">

     // Fungsi untuk mengambil lokasi dari API dan mengisi dropdown
     function loadLocations() {
        fetch('/api/master/locations')
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

    $(document).ready(function () {
        loadLocations();

        // Mengambil data dari API menggunakan AJAX
        $.ajax({
            url: '/stock/api',  // URL API untuk mendapatkan semua stok
            type: 'GET',
            success: function(data) {
                // Data yang diterima dari API
                const stockData = data.map((item, index) => ({
                    id: item.id,
                    material: item.itemCode, // Assuming itemCode is the 'Material'
                    description: item.description,
                    portNumber: item.portNum,
                    baseUnit: item.unitCd,
                    storageLocation: item.locationName
                }));

                // Sumber data untuk jqxGrid
                const source = {
                    localdata: stockData,
                    datatype: "array",
                    datafields: [
                        { name: "id", type: "number" },            // No
                        { name: "material", type: "string" },       // Material
                        { name: "description", type: "string" },    // Description
                        { name: "portNumber", type: "number" },     // Port Number
                        { name: "baseUnit", type: "string" },       // Base Unit
                        { name: "storageLocation", type: "string" } // Storage Location
                    ]
                };

                const dataAdapter = new $.jqx.dataAdapter(source);

                // Inisialisasi jqxGrid dengan data dari API
                $("#jqxgrid").jqxGrid({
                    width: '100%',
                    height: 400,
                    source: dataAdapter,
                    autoheight: true,
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
                        { text: "Description", datafield: "description", width: 180 },  // Lebar untuk Description
                        { text: "Port Number", datafield: "portNumber", width: 100, cellsalign: 'center', align: 'center' }, // Lebar untuk Port Number
                        { text: "Base Unit", datafield: "baseUnit", width: 120 },    // Lebar untuk Base Unit
                        { text: "Storage Location", datafield: "storageLocation", width: 150 } // Lebar untuk Storage Location
                    ]
                });
            },
            error: function(err) {
                console.log('Error fetching data from API', err);
            }
        });
    });
</script>

