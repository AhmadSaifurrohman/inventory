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
    <!-- Tabel menggunakan AdminLTE -->
    <div class="card w-100">
        <div class="card-header">
            <div class="d-flex justify-content-between w-100">
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
                            <button class="btn btn-info" id="excelBtn">Export to Excel</button>
                        </div>
                    </div>
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

<!-- Script untuk menginisialisasi DataTables -->
<script type="text/javascript">
    // Fungsi untuk mengambil lokasi dari API dan mengisi dropdown
    function loadLocations() {
        fetch('${pageContext.request.contextPath}/api/master/locations')
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

        // Mengambil data dari API menggunakan AJAX
        $.ajax({
            url: '${pageContext.request.contextPath}/transactions/api', // URL API untuk mendapatkan semua transaksi
            type: 'GET',
            success: function(data) {
                // Sumber data untuk jqxGrid
                const source = {
                    localdata: data,
                    datatype: "array",
                    datafields: [
                        { name: "transNo", type: "number" },
                        { name: "itemCode", type: "string" },
                        { name: "transactionType", type: "string" },
                        { name: "transQty", type: "number" },
                        { name: "qtyBefore", type: "number" },
                        { name: "qtyAfter", type: "number" },
                        { name: "locBefore", type: "string" },
                        { name: "locAfter", type: "string" },
                        { name: "transDate", type: "date" },
                        { name: "userId", type: "string" }
                    ]
                };

                const dataAdapter = new $.jqx.dataAdapter(source);

                // Inisialisasi jqxGrid dengan data dari API
                $("#jqxgrid").jqxGrid({
                    width: '100%',
                    height: 400,
                    source: dataAdapter,
                    pageable: true,
                    sortable: true,
                    filterable: true,
                    autoshowfiltericon: true,
                    columnsresize: true,
                    columns: [
                        { text: "Transaction No", datafield: "transNo", width: 100 },
                        { text: "Item Code", datafield: "itemCode", width: 150 },
                        { text: "Transaction Type", datafield: "transactionType", width: 150 },
                        { text: "Quantity", datafield: "transQty", width: 100, cellsalign: 'right', align: 'center' },
                        { text: "Qty Before", datafield: "qtyBefore", width: 100, cellsalign: 'right', align: 'center' },
                        { text: "Qty After", datafield: "qtyAfter", width: 100, cellsalign: 'right', align: 'center' },
                        { text: "Location Before", datafield: "locBefore", width: 150 },
                        { text: "Location After", datafield: "locAfter", width: 150 },
                        { text: "Transaction Date", datafield: "transDate", width: 150, cellsformat: 'dd-MM-yyyy HH:mm' },
                        { text: "User", datafield: "userId", width: 100 }
                    ]
                });
            },
            error: function(err) {
                console.error('Error fetching transactions:', err);
            }
        });

        // Event listener untuk tombol search
        $("#searchBtn").on("click", function() {
            const itemCode = $("#itemCodeFilter").val();
            const location = $("#locationFilter").val();
            const queryParams = {};

            if (itemCode) queryParams.itemCode = itemCode;
            if (location) queryParams.location = location;

            // Mengambil data dengan filter menggunakan queryParams
            $.ajax({
                url: '${pageContext.request.contextPath}/transactions/api', 
                type: 'GET',
                data: queryParams,
                success: function(data) {
                    // Update jqxGrid dengan data baru
                    const source = {
                        localdata: data,
                        datatype: "array",
                        datafields: [
                            { name: "transNo", type: "number" },
                            { name: "itemCode", type: "string" },
                            { name: "transactionType", type: "string" },
                            { name: "transQty", type: "number" },
                            { name: "qtyBefore", type: "number" },
                            { name: "qtyAfter", type: "number" },
                            { name: "locBefore", type: "string" },
                            { name: "locAfter", type: "string" },
                            { name: "transDate", type: "date" },
                            { name: "userId", type: "string" }
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
