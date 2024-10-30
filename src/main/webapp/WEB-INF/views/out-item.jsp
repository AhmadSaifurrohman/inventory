<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Barang Out</h1>
            </div>
        </div>
    </div>
</div>

<section class="content">
    <div class="container-fluid">

        <!-- Daftar Barang Out -->
        <div class="card card-primary">
            <div class="card-header">
                <h3 class="card-title">Daftar Barang Out</h3>
            </div>
            <div class="card-body">
                <div id="outItemsGrid"></div>
            </div>
        </div>

        <!-- Form Tambah Barang Out -->
        <div class="card card-secondary mt-4">
            <div class="card-header">
                <h3 class="card-title">Tambah Barang Out</h3>
            </div>
            <form action="${pageContext.request.contextPath}/add-out-item" method="post">
                <div class="card-body">
                    <div class="form-group">
                        <label for="materialCode">Material Code</label>
                        <input type="text" class="form-control" id="materialCode" name="materialCode" placeholder="Masukkan Material Code" required>
                    </div>
                    <div class="form-group">
                        <label for="quantity">Quantity</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" placeholder="Masukkan Jumlah Barang" required>
                    </div>
                    <div class="form-group">
                        <label for="unit">Unit</label>
                        <input type="text" class="form-control" id="unit" name="unit" placeholder="Masukkan Unit" required>
                    </div>
                    <div class="form-group">
                        <label for="recipient">Recipient</label>
                        <input type="text" class="form-control" id="recipient" name="recipient" placeholder="Masukkan Penerima Barang" required>
                    </div>
                    <div class="form-group">
                        <label for="dateOut">Date Out</label>
                        <input type="date" class="form-control" id="dateOut" name="dateOut" required>
                    </div>
                    <div class="form-group">
                        <label for="reason">Reason for Out (optional)</label>
                        <textarea class="form-control" id="reason" name="reason" placeholder="Masukkan Alasan Barang Keluar"></textarea>
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary">Tambah Barang Out</button>
                </div>
            </form>
        </div>
    </div>
</section>

<!-- Script untuk menginisialisasi DataTables atau jqxGrid untuk menampilkan data Barang Out -->
<script src="${pageContext.request.contextPath}/static/plugins/jquery/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        const data = []; // Data dummy untuk menampilkan barang keluar

        // Contoh data dummy
        for (let i = 0; i < 10; i++) {
            data.push({
                transactionId: i + 1,
                materialCode: `MC00${i + 1}`,
                description: `Description for item ${i + 1}`,
                quantity: Math.floor(Math.random() * 100) + 1,
                unit: 'pcs',
                recipient: `Recipient ${i + 1}`,
                dateOut: `2024-0${(i % 12) + 1}-15`
            });
        }

        // Inisialisasi jqxGrid atau DataTable untuk grid
        const source = {
            localdata: data,
            datatype: "array",
            datafields: [
                { name: "transactionId", type: "number" },
                { name: "materialCode", type: "string" },
                { name: "description", type: "string" },
                { name: "quantity", type: "number" },
                { name: "unit", type: "string" },
                { name: "recipient", type: "string" },
                { name: "dateOut", type: "date" }
            ]
        };

        const dataAdapter = new $.jqx.dataAdapter(source);

        $("#outItemsGrid").jqxGrid({
            width: '100%',
            height: 400,
            source: dataAdapter,
            pageable: true,
            sortable: true,
            filterable: true,
            columnsresize: true,
            columns: [
                { text: "Transaction ID", datafield: "transactionId", width: 100 },
                { text: "Material Code", datafield: "materialCode", width: 150 },
                { text: "Description", datafield: "description", width: 200 },
                { text: "Quantity", datafield: "quantity", width: 100, cellsalign: 'center', align: 'center' },
                { text: "Unit", datafield: "unit", width: 100 },
                { text: "Recipient", datafield: "recipient", width: 150 },
                { text: "Date Out", datafield: "dateOut", width: 150, cellsformat: 'yyyy-MM-dd' }
            ]
        });
    });
</script>
