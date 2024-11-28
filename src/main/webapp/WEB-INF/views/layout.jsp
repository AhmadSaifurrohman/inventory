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

    <!-- Select2 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/select2/css/select2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <!-- <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" /> -->

    <style>      
        /* JQWidgets */
        .jqx-widget-header {
            background: #6C757D;
            color: white;
            font-weight: normal;
        }

        .jqx-fill-state-pressed {
            background: #4d5359;
            color: white;
        }

        .jqx-tabs-titleContentWrapper {
            color: white;
        }

        .jqx-widget .jqx-grid-column-menubutton, .jqx-widget .jqx-grid-column-sortascbutton,
            .jqx-widget .jqx-grid-column-sortdescbutton, .jqx-widget .jqx-grid-column-filterbutton
            {
            background-color: white;
        }

        .jqx-menu-vertical {
            background-color: var(--primary01);
            font-weight: normal;
        }

        .jqx-fill-state-pressed {
            background: rgba(var(--primary-rgb), 0.4);
            color: black;
        }

        .jqx-grid-cell-hover {
            background-color: var(--primary01);
            color: black;
            font-weight: normal;
        }

        .jqx-grid-cell {
            font-weight: normal;
        }

        .jqx-tabs-content-element {
            height: 100%;
            overflow: auto;
        }

        smart-tabs {
            width: 100%;
            height: 90vh;
        }

        /* Padding Grid Fill */
        .jqx-grid-cell-left-align {
            padding: 0px 5px;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">
    

    <!-- AdminLTE JS -->
    <!-- <script src="${pageContext.request.contextPath}/static/plugins/jquery/jquery.min.js"></script> -->
    <script src="${pageContext.request.contextPath}/static/plugins/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/dist/js/adminlte.min.js"></script>

    <!-- Select2 -->
    <script src="${pageContext.request.contextPath}/static/plugins/select2/js/select2.full.min.js"></script>
    <!-- <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script> -->

    <!-- JQWidgets -->
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
