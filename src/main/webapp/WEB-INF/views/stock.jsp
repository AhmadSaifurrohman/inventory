<h1 class="m-0">Stock List</h1>
<p class="lead">Berikut adalah daftar stok barang di gudang.</p>

<!-- Tabel menggunakan AdminLTE -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">Daftar Stok Barang</h3>
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
    $(document).ready(function () {
        // Data dummy untuk grid
        const data = [];
        for (let i = 0; i < 100; i++) {
            data.push({
                id: i + 1,
                firstName: 'FirstName ${i + 1}',
                lastName: 'LastName ${i + 1}',
                age: 'Math.floor(Math.random() * 50) + 20',
                email: 'user${i + 1}@example.com',
                phone: '555-01${i + 1}',
                address: 'Street ${i + 1}, City ${i + 1}',
                department: 'Department ${i % 5}',
                position: 'Position ${i % 10}',
                salary: 'Math.floor(Math.random() * 50000) + 30000',
                hireDate: '202${i % 10}-0${(i % 12) + 1}-01'
            });
        }

        // Sumber data untuk jqxGrid
        const source = {
            localdata: data,
            datatype: "array",
            datafields: [
                { name: "id", type: "number" },
                { name: "firstName", type: "string" },
                { name: "lastName", type: "string" },
                { name: "age", type: "number" },
                { name: "email", type: "string" },
                { name: "phone", type: "string" },
                { name: "address", type: "string" },
                { name: "department", type: "string" },
                { name: "position", type: "string" },
                { name: "salary", type: "number" },
                { name: "hireDate", type: "date" }
            ]
        };

        const dataAdapter = new $.jqx.dataAdapter(source);

        // Inisialisasi jqxGrid
        $("#jqxgrid").jqxGrid({
            width: '100%',
            height: 400,
            source: dataAdapter,
            pageable: true,
            sortable: true,
            filterable: true,
            columnsresize: true,
            autoshowfiltericon: true,
            columns: [
                { text: "ID", datafield: "id", width: 50 },
                { text: "First Name", datafield: "firstName", width: 120 },
                { text: "Last Name", datafield: "lastName", width: 120 },
                { text: "Age", datafield: "age", width: 50, cellsalign: 'center', align: 'center' },
                { text: "Email", datafield: "email", width: 180 },
                { text: "Phone", datafield: "phone", width: 100 },
                { text: "Address", datafield: "address", width: 250 },
                { text: "Department", datafield: "department", width: 100 },
                { text: "Position", datafield: "position", width: 100 },
                { text: "Salary", datafield: "salary", width: 100, cellsformat: 'c2', cellsalign: 'right' },
                { text: "Hire Date", datafield: "hireDate", width: 100, cellsformat: 'yyyy-MM-dd' }
            ]
        });
    });
</script>