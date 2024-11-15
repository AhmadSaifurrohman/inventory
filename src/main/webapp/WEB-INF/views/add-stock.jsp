<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Add Stock</h1>
            </div>
        </div>
    </div>
</div>

<section class="content">
    <div class="container-fluid">
        <div class="card card-primary">
            <div class="card-header">
                <h3 class="card-title">Form Add Stock</h3>
            </div>

            <!-- Form Tambah Barang -->
            <form id="stockForm" method="post">
                <div class="card-body">
                    <div class="form-group">
                        <label for="materialCode">Material Code</label>
                        <select class="form-control" id="materialCode" name="materialCode" required>
                            <option value=""  selected>Pilih Material Code</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <input type="text" class="form-control" id="description" name="description" placeholder="Masukkan Deskripsi" required>
                    </div>
                    <div class="form-group">
                        <label for="portNumber">Port Number</label>
                        <input type="text" class="form-control" id="portNumber" name="portNumber" placeholder="Masukkan Port Number" required>
                    </div>
                    <div class="form-group">
                        <label for="unit">Unit</label>
                        <select class="form-control" id="unit" name="unit" required>
                            <option value=""  selected>Pilih Unit</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="rackLocation">Rack Location</label>
                        <select class="form-control" id="rackLocation" name="rackLocation" required>
                            <option value=""  selected>Pilih Lokasi Rak</option>
                        </select>
                    </div>
                </div>

                <!-- Tombol Submit -->
                <div class="card-footer">
                    <button type="button" class="btn btn-primary" onclick="saveStock()">Tambah Barang</button>
                </div>
            </form>
        </div>
    </div>
</section>

<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="${pageContext.request.contextPath}/static/plugins/jquery/jquery.min.js"></script>

<!-- JavaScript untuk menampilkan notifikasi SweetAlert -->
<% if (request.getAttribute("successMessage") != null) { %>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Berhasil!',
        text: '<%= request.getAttribute("successMessage") %>',
        showConfirmButton: false,
        timer: 2000
    });
</script>
<% } %>

<script>
    $(document).ready(function () {
        // AJAX untuk mengambil data Material Code
        $.ajax({
            url: '${pageContext.request.contextPath}/api/master/items',
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
            url: '${pageContext.request.contextPath}/api/master/units',
            type: 'GET',
            success: function (data) {
                let unitDropdown = $('#unit');
                data.forEach(function (unit) {
                    unitDropdown.append('<option value="' + unit.unitCd + '">' + unit.description + '</option>');
                });
            },
            error: function (err) {
                console.error("Error fetching rack locations:", err);
            }
        });

        // AJAX untuk mengambil data Rack Location
        $.ajax({
            url: '${pageContext.request.contextPath}/api/master/locations',
            type: 'GET',
            success: function (data) {
                let rackLocationDropdown = $('#rackLocation');
                data.forEach(function (location) {
                    rackLocationDropdown.append('<option value="' + location.locCd + '">' + location.location + '</option>');
                });
            },
            error: function (err) {
                console.error("Error fetching rack locations:", err);
            }
        });
    });

    // Function to save stock via AJAX
    function saveStock() {
        const stockData = {
            itemCode: $('#materialCode').val(),
            description: $('#description').val(),
            portNum: $('#portNumber').val(),
            unitCd: $('#unit').val(),
            location: $('#rackLocation').val(),
        };

         // Menampilkan setiap variabel di console
        console.log("Material Code:", stockData.itemCode);
        console.log("Description:", stockData.description);
        console.log("Port Number:", stockData.portNum);
        console.log("Unit:", stockData.unitCd);
        console.log("Rack Location:", stockData.location);

        $.ajax({
            url: '${pageContext.request.contextPath}/stock/api',
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
                $('#stockForm')[0].reset();
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
</script>
