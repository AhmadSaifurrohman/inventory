<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="#" class="brand-link">
        <span class="brand-text font-weight-light">Inventory</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <li class="nav-item">
                    <a href="/" class="nav-link ${currentUrl == '/' ? 'active' : ''}">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li class="nav-item">
                  <a href="/stock" class="nav-link ${currentUrl == '/stock' ? 'active' : ''}">
                      <i class="nav-icon fas fa-box"></i>
                      <p>Stock</p>
                  </a>
                </li>
                <li class="nav-item">
                    <a href="/add-item" class="nav-link ">
                        <i class="nav-icon fas fa-plus"></i>
                        <p>Stock Transaksi</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/master" class="nav-link ${currentUrl == '/master' ? 'active' : ''}">
                        <i class="nav-icon fas fa-pencil-alt"></i>
                        <p>Master Data</p>
                    </a>
                </li>
                <!-- <li class="nav-item">
                    <a href="#" class="nav-link">
                      <i class="nav-icon fas fa-pencil-alt"></i>
                      <p>
                        Master Data
                        <i class="right fas fa-angle-left"></i>
                      </p>
                    </a>
                    <ul class="nav nav-treeview">
                      <li class="nav-item">
                        <a href="./index.html" class="nav-link">
                          <i class="far fa-circle nav-icon"></i>
                          <p>Lokasi</p>
                        </a>
                      </li>
                      <li class="nav-item">
                        <a href="./index2.html" class="nav-link">
                          <i class="far fa-circle nav-icon"></i>
                          <p>Material Code</p>
                        </a>
                      </li>
                      <li class="nav-item">
                        <a href="./index3.html" class="nav-link">
                          <i class="far fa-circle nav-icon"></i>
                          <p>Unit</p>
                        </a>
                      </li>
                    </ul>
                </li> -->
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>
