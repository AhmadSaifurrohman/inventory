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
                    <a href="/transactions" class="nav-link ${currentUrl == '/transactions' ? 'active' : ''}">
                        <i class="nav-icon fas fa-external-link-alt"></i>
                        <p>Stock Transaksi</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/stock/adjustment" class="nav-link ${currentUrl == '/stock/adjustment' ? 'active' : ''}">
                        <i class="nav-icon fas fa-edit"></i>
                        <p>Stock Adjusment</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/master" class="nav-link ${currentUrl == '/master' ? 'active' : ''}">
                        <i class="nav-icon fas fa-pencil-alt"></i>
                        <p>Master Data</p>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>
