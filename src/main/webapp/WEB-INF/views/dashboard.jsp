<!-- <h1 class="m-0">Welcome to Inventory Management System</h1> -->
<!-- <p class="lead">Manage your products, stocks, and more with ease.</p> -->

<div class="row">
    <div class="col-12 col-sm-6 col-md-3">
      <div class="info-box">
        <span class="info-box-icon bg-info elevation-1"><i class="fas fa-tools"></i></span>
  
        <div class="info-box-content">
          <span class="info-box-text">Total Item</span>
          <span class="info-box-number" id="totalItem"></span>
        </div>
        <!-- /.info-box-content -->
      </div>
      <!-- /.info-box -->
    </div>
    <!-- /.col -->
    <div class="col-12 col-sm-6 col-md-3">
      <div class="info-box mb-3">
        <span class="info-box-icon bg-success elevation-1"><i class="fas fa-thumbs-up"></i></span>
  
        <div class="info-box-content">
          <span class="info-box-text">Total Inbound</span>
          <span class="info-box-number" id="totalInbound"></span>
        </div>
        <!-- /.info-box-content -->
      </div>
      <!-- /.info-box -->
    </div>
    <!-- /.col -->
  
    <!-- fix for small devices only -->
    <div class="clearfix hidden-md-up"></div>
  
    <div class="col-12 col-sm-6 col-md-3">
      <div class="info-box mb-3">
        <span class="info-box-icon bg-danger elevation-1"><i class="fas fa-shopping-cart"></i></span>
  
        <div class="info-box-content">
          <span class="info-box-text">Total Outbound</span>
          <span class="info-box-number" id="totalOutbound"></span>
        </div>
        <!-- /.info-box-content -->
      </div>
      <!-- /.info-box -->
    </div>
    <!-- /.col -->
    <div class="col-12 col-sm-6 col-md-3">
      <div class="info-box mb-3">
        <span class="info-box-icon bg-warning elevation-1"><i class="fas fa-users"></i></span>
  
        <div class="info-box-content">
          <span class="info-box-text">New Members</span>
          <span class="info-box-number">2,000</span>
        </div>
        <!-- /.info-box-content -->
      </div>
      <!-- /.info-box -->
    </div>
    <!-- /.col -->
</div>

<div class="row">
    <div class="col-md-6">
        <div class="card card-secondary card-tabs">
            <div class="card-header p-0 pt-1">
                <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="custom-tabs-one-home-tab" data-toggle="pill" href="#custom-tabs-one-home" role="tab" aria-controls="custom-tabs-one-home" aria-selected="true">Stock mendekati Safety</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="custom-tabs-one-profile-tab" data-toggle="pill" href="#custom-tabs-one-profile" role="tab" aria-controls="custom-tabs-one-profile" aria-selected="false">Stock dibawah Safety </a>
                  </li>
                </ul>
              </div>
              <div class="card-body">
                <div class="tab-content" id="custom-tabs-one-tabContent">
                    <div class="tab-pane fade show active" id="custom-tabs-one-home" role="tabpanel" aria-labelledby="custom-tabs-one-home-tab">
                        <div class="table-responsive">
                            <table class="table table-striped table-valign-middle" id="findStockApproachSafetyQty">
                                <thead>
                                    <tr>
                                        <th>Item Code</th>
                                        <th>Part Number</th>
                                        <th>Stock</th>
                                        <th>Safety Stock</th>
                                        <th>Location</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data akan diisi oleh Ajax -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="custom-tabs-one-profile" role="tabpanel" aria-labelledby="custom-tabs-one-profile-tab">
                        <div class="table-responsive">
                            <table class="table table-striped table-valign-middle" id="findStockUnderSafetyQty">
                                <thead>
                                    <tr>
                                        <th>Item Code</th>
                                        <th>Part Number</th>
                                        <th>Stock</th>
                                        <th>Safety Stock</th>
                                        <th>Location</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Data akan diisi oleh Ajax -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function() {
        // Panggil API untuk mendapatkan data summary stok
        $.ajax({
            url: 'api/findStockApproachSafetyQty', // URL API yang sesuai dengan endpoint di controller
            method: 'GET',
            success: function(data) {
                console.log('Hasil data', data);
                var tbody = $('#findStockApproachSafetyQty tbody');
                tbody.empty(); // Hapus data sebelumnya (jika ada)
    
                // Loop melalui data dan tampilkan ke dalam tabel
                data.forEach(function(item) {
                    var row = '<tr>' +
                                '<td>' + item.itemCode + '</td>' +
                                '<td>' + item.partNum + '</td>' +
                                '<td>' + item.stock + '</td>' +
                                '<td>' + item.safetyStock + '</td>' +
                                '<td>' + item.location + '</td>' +
                                '<td>' + item.stockStatus + '</td>' +
                              '</tr>';
                    tbody.append(row);
                });
            },
            error: function(xhr, status, error) {
                console.error("Error fetching data: ", error);
            }
        });

        $.ajax({
            url: 'api/findStockUnderSafetyQty', // URL API yang sesuai dengan endpoint di controller
            method: 'GET',
            success: function(data) {
                console.log('Hasil data', data);
                var tbody = $('#findStockUnderSafetyQty tbody');
                tbody.empty(); // Hapus data sebelumnya (jika ada)
    
                // Loop melalui data dan tampilkan ke dalam tabel
                data.forEach(function(item) {
                    var row = '<tr>' +
                                '<td>' + item.itemCode + '</td>' +
                                '<td>' + item.partNum + '</td>' +
                                '<td>' + item.stock + '</td>' +
                                '<td>' + item.safetyStock + '</td>' +
                                '<td>' + item.location + '</td>' +
                                '<td>' + item.stockStatus + '</td>' +
                              '</tr>';
                    tbody.append(row);
                });
            },
            error: function(xhr, status, error) {
                console.error("Error fetching data: ", error);
            }
        });

        $.ajax({
            url: '/api/dashboard', // Endpoint API yang sesuai
            method: 'GET',
            success: function(data) {
                console.log('hasil console', data);
                // Update elemen dengan ID sesuai dengan data yang diterima
                $('#totalInbound').text(data.totalInboundTransactions.toLocaleString());
                $('#totalOutbound').text(data.totalOutboundTransactions.toLocaleString());
                $('#totalItem').text(data.totalItem.toLocaleString());
            },
            error: function(xhr, status, error) {
                console.error("Error fetching data: ", error);
            }
        });
    });
    </script>