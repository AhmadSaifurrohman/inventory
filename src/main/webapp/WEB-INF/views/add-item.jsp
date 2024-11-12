<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Tambah Barang</h1>
            </div>
        </div>
    </div>
</div>

<section class="content">
    <div class="container-fluid">
        <div class="card card-primary">
            <div class="card-header">
                <h3 class="card-title">Form Tambah Barang</h3>
            </div>

            <!-- Form Tambah Barang -->
            <form action="${pageContext.request.contextPath}/add-item" method="post">
                <div class="card-body">
                    <div class="form-group">
                        <label for="materialCode">Material Code</label>
                        <input type="text" class="form-control" id="materialCode" name="materialCode" placeholder="Masukkan Material Code" required>
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
                        <input type="text" class="form-control" id="unit" name="unit" placeholder="Masukkan Unit" required>
                    </div>
                    <div class="form-group">
                        <label for="rackLocation">Rack Location</label>
                        <input type="text" class="form-control" id="rackLocation" name="rackLocation" placeholder="Masukkan Lokasi Rak" required>
                    </div>
                </div>

                <!-- Tombol Submit -->
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary">Tambah Barang</button>
                </div>
            </form>
        </div>
    </div>
</section>

<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
