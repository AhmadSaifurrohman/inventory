<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management System</title>

    <!-- AdminLTE CSS -->
    <link href="${pageContext.request.contextPath}/static/dist/css/adminlte.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/plugins/fontawesome-free/css/all.min.css" rel="stylesheet">

    <!-- JQWidgets Base -->
    <link href="${pageContext.request.contextPath}/static/jqwidgets/styles/jqx.base.css" rel="stylesheet">

    <!-- daterange picker -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/daterangepicker/daterangepicker.css">

    <!-- Select2 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">

    <style>
        /* Prevent global margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box; /* Ensures padding/borders don't overflow */
        }

        /* Full height for html and body */
        html, body {
            height: 100%;
            width: 100%;
            overflow: hidden; /* Prevent unwanted scroll */
        }

        /* Content wrapper fills the screen height */
        .content-wrapper {
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensures it takes at least full screen height */
            overflow: hidden; /* Prevent overflow on the wrapper */
        }

        /* Content area, allow vertical scrolling only when needed */
        .content {
            flex: 1; /* Take up available space */
            overflow-y: auto; /* Enable vertical scrolling for content */
            padding-right: 15px; /* Prevent overflow from horizontal scrollbar */
        }

        /* Prevent any overflow or scroll in container */
        .container-fluid {
            height: 100%;
            overflow: hidden;
        }

        /* Ensure jqxGrid does not cause horizontal overflow */
        .jqx-grid-cell {
            font-weight: normal;
        }

        .jqx-widget-header {
            background: #6C757D;
            color: white;
            font-weight: normal;
        }

        /* Specific style for jqxGrid to prevent horizontal scroll */
        #jqxgrid {
            width: 100%;
            height: 300px; /* Adjust height as necessary */
            overflow: hidden; /* Prevent overflow in jqxGrid */
            box-sizing: border-box;
        }

        /* Ensure jqx grid does not expand outside its bounds */
        .jqx-grid {
            width: 100%;
            height: 100%;
            overflow: hidden; /* Avoid horizontal/vertical scroll */
        }

    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">

    <!-- AdminLTE JS -->
    <script src="${pageContext.request.contextPath}/static/plugins/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/dist/js/adminlte.min.js"></script>

    <!-- Select2 JS -->
    <script src="${pageContext.request.contextPath}/static/plugins/select2/js/select2.full.min.js"></script>

    <!-- InputMask -->
    <script src="${pageContext.request.contextPath}/static/plugins/moment/moment.min.js"></script>

    <!-- Date Range Picker -->
    <script src="${pageContext.request.contextPath}/static/plugins/daterangepicker/daterangepicker.js"></script>

    <!-- JQWidgets JS -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxgrid.edit.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxgrid.selection.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxgrid.aggregates.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxgrid.sort.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxgrid.filter.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxcheckbox.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxcalendar.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxdatetimeinput.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxnumberinput.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxrating.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jqwidgets/jqxgrid.pager.js"></script>

    <div class="wrapper">
        <!-- Header -->
        <jsp:include page="layout/header.jsp" />

        <!-- Sidebar -->
        <jsp:include page="layout/sidebar.jsp" />

        <!-- Content Wrapper -->
        <div class="content-wrapper">
            <title><%= request.getAttribute("title") != null ? request.getAttribute("title") : "Inventory Management System" %></title>
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1><%= request.getAttribute("title") != null ? request.getAttribute("title") : "" %></h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active"><%= request.getAttribute("title") != null ? request.getAttribute("title") : "" %></li>
                        </ol>
                    </div>
                    </div>
                </div><!-- /.container-fluid -->
            </section>

            <section class="content">
                <div class="container-fluid">
                    <!-- Menyertakan konten dinamis -->
                    <jsp:include page="${content}" />
                </div>
            </section>
        </div>

        <!-- Footer -->
        <jsp:include page="layout/footer.jsp" />
    </div>
    
</body>
</html>