<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  .card-body {
    max-height: 500px; /* Atur tinggi maksimum untuk konten */
    overflow-y: auto;  /* Aktifkan scroll ketika konten melebihi tinggi */
  }
</style>


<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Master Data</h1>
            </div>
        </div>
    </div>
</div>

<section class="content">
  <div class="row">
    <div class="col-md-4">
        <div class="card card-secondary">
            <div class="card-header">
                <h3 class="card-title">Location 1</h3>
                <div class="card-tools">
                    <button type="button" id="addLoc" class="btn btn-primary btn-sm">
                      <i class="fas fa-plus"></i> Add
                    </button>
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                      <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div id="jqxGrid1"></div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card card-secondary">
            <div class="card-header">
                <h3 class="card-title">ItemCode</h3>
                <div class="card-tools">
                    <button type="button" id="AddItemCode" class="btn btn-primary btn-sm">
                      <i class="fas fa-plus"></i> Add
                    </button>
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div id="jqxGrid2"></div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card card-secondary">
            <div class="card-header">
                <h3 class="card-title">Unit</h3>
                <div class="card-tools">
                    <button type="button" id="addUnit" class="btn btn-primary btn-sm">
                      <i class="fas fa-plus"></i> Add
                    </button>
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div id="jqxGrid3"></div>
            </div>
        </div>
    </div>
  </div>
</section>

<!-- Modal for adding Location -->
<div class="modal fade" id="addLocationModal" tabindex="-1" aria-labelledby="addLocationModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addLocationModalLabel">Add Location</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="addLocationForm">
          <div class="mb-3">
            <label for="locationId" class="form-label">Location ID</label>
            <input type="number" class="form-control" id="locationId" required>
          </div>
          <div class="mb-3">
            <label for="locationName" class="form-label">Location Name</label>
            <input type="text" class="form-control" id="locationName" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="saveLocation">Save changes</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal for adding ItemCode -->
<div class="modal fade" id="addItemCodeModal" tabindex="-1" aria-labelledby="addItemCodeModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addItemCodeModalLabel">Add Item Code</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="addItemCodeForm">
          <div class="mb-3">
            <label for="itemId" class="form-label">Item ID</label>
            <input type="number" class="form-control" id="itemId" required>
          </div>
          <div class="mb-3">
            <label for="itemCode" class="form-label">Item Code</label>
            <input type="text" class="form-control" id="itemCode" required>
          </div>
          <div class="mb-3">
            <label for="itemName" class="form-label">Item Name</label>
            <input type="text" class="form-control" id="itemName" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="saveItemCode">Save changes</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal for adding Unit -->
<div class="modal fade" id="addUnitModal" tabindex="-1" aria-labelledby="addUnitModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addUnitModalLabel">Add Unit</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="addUnitForm">
          <div class="mb-3">
            <label for="unitId" class="form-label">Unit ID</label>
            <input type="number" class="form-control" id="unitId" required>
          </div>
          <div class="mb-3">
            <label for="unitName" class="form-label">Unit Name</label>
            <input type="text" class="form-control" id="unitName" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="saveUnit">Save changes</button>
      </div>
    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/static/plugins/jquery/jquery.min.js"></script>
<script>
  $(document).ready(function () {
      // Data for each grid
      var dataLocation = [
          { id: 1, location: 'Security Room' },
          { id: 2, location: 'Main Office' },
          { id: 3, location: 'Warehouse' },
          { id: 4, location: 'Auditorium' },
          { id: 5, location: 'IT Room' },
          { id: 6, location: 'Control Room' }

      ];

      var dataItemCode = [
          { id: 1, itemCode: 'ITM001', name: 'Laptop' },
          { id: 2, itemCode: 'ITM002', name: 'Mouse' },
          { id: 3, itemCode: 'ITM003', name: 'Router' },
          { id: 4, itemCode: 'ITM004', name: 'Keyboard' },
          { id: 5, itemCode: 'ITM005', name: 'Monitor' },
          { id: 6, itemCode: 'ITM006', name: 'Printer' },
          { id: 7, itemCode: 'ITM007', name: 'Scanner' },
          { id: 8, itemCode: 'ITM008', name: 'Tablet' },
          { id: 9, itemCode: 'ITM009', name: 'Smartphone' },
          { id: 10, itemCode: 'ITM010', name: 'Smartwatch' },
          { id: 11, itemCode: 'ITM011', name: 'Camera' },
          { id: 12, itemCode: 'ITM007', name: 'Scanner' },
          { id: 13, itemCode: 'ITM008', name: 'Tablet' },
          { id: 14, itemCode: 'ITM009', name: 'Smartphone' },
          { id: 15, itemCode: 'ITM010', name: 'Smartwatch' },
          { id: 16, itemCode: 'ITM011', name: 'Camera' }
      ];

      var dataUnit = [
          { id: 1, unit: 'Piece' },
          { id: 2, unit: 'Box' },
          { id: 3, unit: 'Carton' },
          { id: 4, unit: 'Bundle' },
          { id: 5, unit: 'Pallet' },
          { id: 6, unit: 'Package' },
          { id: 7, unit: 'Set' },
          { id: 8, unit: 'Unit' },
          { id: 9, unit: 'Case' },
          { id: 10, unit: 'Container' },
          { id: 11, unit: 'Roll' }
      ];

      // Create data sources
      var sourceLocation = {
          localdata: dataLocation,
          datatype: "array",
          datafields: [
              { name: 'id', type: 'number' },
              { name: 'location', type: 'string' }
          ]
      };

      var sourceItemCode = {
          localdata: dataItemCode,
          datatype: "array",
          datafields: [
              { name: 'id', type: 'number' },
              { name: 'itemCode', type: 'string' },
              { name: 'name', type: 'string' }
          ]
      };

      var sourceUnit = {
          localdata: dataUnit,
          datatype: "array",
          datafields: [
              { name: 'id', type: 'number' },
              { name: 'unit', type: 'string' }
          ]
      };

      var dataAdapterLocation = new $.jqx.dataAdapter(sourceLocation);
      var dataAdapterItemCode = new $.jqx.dataAdapter(sourceItemCode);
      var dataAdapterUnit = new $.jqx.dataAdapter(sourceUnit);

      // Initialize jqxGrid for Location
      $("#jqxGrid1").jqxGrid({
          width: '100%',
          autoheight: true,
          pageable: true,
          pagesize: 10, // Show 10 rows per page
          source: dataAdapterLocation,
          columnsresize: true,
          pagerMode: 'default',
          columns: [
              { text: 'ID', datafield: 'id', width: '10%' },
              { text: 'Location', datafield: 'location', width: '90%' }
          ]
      });

      // Initialize jqxGrid for ItemCode
      $("#jqxGrid2").jqxGrid({
          width: '100%',
          autoheight: true,
          pageable: true,
          pagesize: 10, // Show 10 rows per page
          source: dataAdapterItemCode,
          columnsresize: true,
          pagerMode: 'default',
          columns: [
              { text: 'ID', datafield: 'id', width: '10%' },
              { text: 'Item Code', datafield: 'itemCode', width: '45%' },
              { text: 'Name', datafield: 'name', width: '45%' }
          ]
      });

      // Initialize jqxGrid for Unit
      $("#jqxGrid3").jqxGrid({
          width: '100%',
          autoheight: true,
          pageable: true,
          pagesize: 10, // Show 10 rows per page
          source: dataAdapterUnit,
          columnsresize: true,
          pagerMode: 'default',
          columns: [
              { text: 'ID', datafield: 'id', width: '10%' },
              { text: 'Unit', datafield: 'unit', width: '90%' }
          ]
      });



    // Open modal when clicking 'Add' button
    $('#addLoc').click(function () {
        $('#addLocationModal').modal('show');
    });

    $('#AddItemCode').click(function () {
        $('#addItemCodeModal').modal('show');
    });

    $('#addUnit').click(function () {
        $('#addUnitModal').modal('show');
    });

    // Save Location
    $('#saveLocation').click(function () {
        var id = $('#locationId').val();
        var location = $('#locationName').val();

        if (id && location) {
            // Add new row to jqxGrid
            $("#jqxGrid1").jqxGrid('addrow', null, { id: id, location: location });
            $('#addLocationModal').modal('hide');
            $('#addLocationForm')[0].reset(); // Reset form
        }
    });

    // Save ItemCode
    $('#saveItemCode').click(function () {
        var id = $('#itemId').val();
        var itemCode = $('#itemCode').val();
        var name = $('#itemName').val();

        if (id && itemCode && name) {
            // Add new row to jqxGrid
            $("#jqxGrid2").jqxGrid('addrow', null, { id: id, itemCode: itemCode, name: name });
            $('#addItemCodeModal').modal('hide');
            $('#addItemCodeForm')[0].reset(); // Reset form
        }
    });

    // Save Unit
    $('#saveUnit').click(function () {
        var id = $('#unitId').val();
        var unit = $('#unitName').val();

        if (id && unit) {
            // Add new row to jqxGrid
            $("#jqxGrid3").jqxGrid('addrow', null, { id: id, unit: unit });
            $('#addUnitModal').modal('hide');
            $('#addUnitForm')[0].reset(); // Reset form
        }
    });
  });



</script>
