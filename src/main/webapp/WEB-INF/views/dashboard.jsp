<div class="row">
    <div class="col-12 col-sm-6 col-md-3">
      <div class="info-box">
        <span class="info-box-icon bg-info elevation-1"><i class="fas fa-cubes"></i></span>
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
        <span class="info-box-icon bg-success elevation-1"><i class="fas fa-shopping-cart"></i></span>
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
        <span class="info-box-icon bg-warning elevation-1"><i class="fas fa-truck-loading"></i></span>
  
        <div class="info-box-content">
          <span class="info-box-text">Total Stock</span>
          <span class="info-box-number" id="totalStock"></span>
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
                        <div class="table-responsive" style="height: 500px; overflow-y: auto;">
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

    <!-- Chart Bar Horizontal -->
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Top 10 Barang Paling Banyak Dikeluarkan</h3>
                <!-- Filter Tahun dan Bulan di dalam Card Header -->
                <div class="card-tools">
                    <div class="form-inline">
                        <label for="yearFilter" class="mr-2">Tahun</label>
                        <select id="yearFilter" class="form-control mr-3">
                            <!-- Tahun akan diisi secara dinamis dengan JavaScript -->
                        </select>
    
                        <label for="monthFilter" class="mr-2">Bulan</label>
                        <select id="monthFilter" class="form-control">
                            <option value="1">Januari</option>
                            <option value="2">Februari</option>
                            <option value="3">Maret</option>
                            <option value="4">April</option>
                            <option value="5">Mei</option>
                            <option value="6">Juni</option>
                            <option value="7">Juli</option>
                            <option value="8">Agustus</option>
                            <option value="9">September</option>
                            <option value="10">Oktober</option>
                            <option value="11">November</option>
                            <option value="12">Desember</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="card-body" style="height: 500px; overflow-y: auto;">
                <canvas id="stockChart" width="400" height="300"></canvas>
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
                $('#totalStock').text(data.totalStock.toLocaleString());
            },
            error: function(xhr, status, error) {
                console.error("Error fetching data: ", error);
            }
        });

        // Set default tahun dan bulan (misalnya, tahun ini dan bulan ini)
        var currentYear = new Date().getFullYear();
        var currentMonth = new Date().getMonth() + 1; // Bulan dimulai dari 0, jadi kita tambahkan 1

        // Mengisi dropdown tahun
        for (var year = currentYear - 5; year <= currentYear + 5; year++) {
            $('#yearFilter').append('<option value="' + year + '">' + year + '</option>');
        }
        $('#yearFilter').val(currentYear); // Set default tahun ke tahun ini

        // Mengisi dropdown bulan
        $('#monthFilter').val(currentMonth); // Set default bulan ke bulan ini

        // Mengatur event ketika dropdown tahun atau bulan berubah
        $('#yearFilter, #monthFilter').change(function() {
            var selectedYear = $('#yearFilter').val();
            var selectedMonth = $('#monthFilter').val();
            console.log('Fetching data for:', selectedYear, selectedMonth); // Debugging
            fetchTop10Items(selectedYear, selectedMonth); // Memanggil fungsi untuk fetch data baru
        });

        // Memanggil API untuk mendapatkan data Top 10 Barang yang paling banyak dikeluarkan
        var stockChart = null; // Instance chart global
        function fetchTop10Items(year, month){
            $.ajax({
                url: '/api/top10MostRequested', // Endpoint API untuk Top 10 Items
                method: 'GET',
                data: {
                    year: year,
                    month: month
                },
                success:function(data){
                    console.log('Top 10 Barang Data: ', data);
                
                    // Persiapkan data untuk Chart.js
                    var labels = [];
                    var quantities = [];

                    data.forEach(function(item) {
                        labels.push(item.itemCode);  // ItemCode sebagai label
                        quantities.push(item.totalQty);  // Total Quantity yang dikeluarkan
                    });

                    // Jika chart sudah ada, hancurkan chart lama
                    if (stockChart != null) {
                        stockChart.destroy();
                    }

                    // Data untuk chart
                    var chartData = {
                        labels: labels,
                        datasets: [{
                            label: 'Total Quantity',
                            data: quantities,
                            backgroundColor: 'rgba(54, 162, 235, 0.2)', // Warna bar chart
                            borderColor: 'rgba(54, 162, 235, 1)', // Warna border
                            borderWidth: 1
                        }]
                    };

                    // Konfigurasi Chart.js
                    var ctx = document.getElementById('stockChart').getContext('2d');
                    stockChart = new Chart(ctx, {
                        type: 'bar',
                        data: chartData,
                        options: {
                            responsive: true,
                            indexAxis: 'y', // Sumbu Y untuk item, X untuk quantity
                            scales: {
                                x: {
                                    beginAtZero: true,
                                },
                                y: {
                                    beginAtZero: true
                                }
                            },
                            plugins: {
                                legend: {
                                    display: false
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function(tooltipItem) {
                                            return tooltipItem.raw + ' unit';
                                        }
                                    }
                                }
                            }
                        }
                    })
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching data: ", error);
                }
            })
        }

        // Fetch default data ketika halaman pertama kali dimuat
        fetchTop10Items(currentYear, currentMonth);
        
    });
</script>