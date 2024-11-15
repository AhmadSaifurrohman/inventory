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
            <label for="locationId" class="form-label">Location Code</label>
            <input type="text" class="form-control" id="locationId" required>
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
            <label for="itemCode" class="form-label">Item Code</label>
            <input type="text" class="form-control" id="itemCode" required>
          </div>
          <div class="mb-3">
            <label for="itemName" class="form-label">Item Name</label>
            <input type="text" class="form-control" id="itemName" required>
          </div>
          <div class="mb-3">
            <label for="descriptionItem" class="form-label">Description</label>
            <input type="text" class="form-control" id="descriptionItem" required>
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
            <label for="unitId" class="form-label">Unit Code</label>
            <input type="text" class="form-control" id="unitId" required>
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
    // Data for each grid from API
    $.ajax({
        url: '/api/master/locations', // Replace with your actual endpoint
        method: 'GET',
        success: function(dataLocation) {
            // Modify the response to replace 'id' with 'no'
            dataLocation = dataLocation.map(function(item, index) {
                item.no = index + 1; // Assign a 'no' based on the index
                delete item.id; // Remove 'id' field if necessary
                return item;
            });

            // Data Adapter for Location
            var sourceLocation = {
                localdata: dataLocation,
                datatype: "array",
                datafields: [
                    { name: 'no', type: 'number' },
                    { name: 'locCd', type: 'string' },
                    { name: 'location', type: 'string' }
                ]
            };

            var dataAdapterLocation = new $.jqx.dataAdapter(sourceLocation);

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
                    { text: 'No', datafield: 'no', width: '10%' },
                    { text: 'Loc Code', datafield: 'locCd', width: '20%' },
                    { text: 'Location', datafield: 'location', width: '70%' }
                ]
            });
        },
        error: function() {
            alert('Failed to load location data.');
        }
    });

    // Similar changes for item and unit grids
    $.ajax({
        url: '/api/master/items', // Replace with your actual endpoint
        method: 'GET',
        success: function(dataItemCode) {
            // Modify the response to replace 'id' with 'no'
            dataItemCode = dataItemCode.map(function(item, index) {
                item.no = index + 1; // Assign a 'no' based on the index
                delete item.id; // Remove 'id' field if necessary
                return item;
            });

            // Data Adapter for ItemCode
            var sourceItemCode = {
                localdata: dataItemCode,
                datatype: "array",
                datafields: [
                    { name: 'no', type: 'number' },
                    { name: 'itemCode', type: 'string' },
                    { name: 'itemName', type: 'string' }
                ]
            };

            var dataAdapterItemCode = new $.jqx.dataAdapter(sourceItemCode);

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
                    { text: 'No', datafield: 'no', width: '10%' },
                    { text: 'Item Code', datafield: 'itemCode', width: '45%' },
                    { text: 'Name', datafield: 'itemName', width: '45%' }
                ]
            });
        },
        error: function() {
            alert('Failed to load item data.');
        }
    });

    $.ajax({
        url: '/api/master/units', // Replace with your actual endpoint
        method: 'GET',
        success: function(dataUnit) {
            // Modify the response to replace 'id' with 'no'
            dataUnit = dataUnit.map(function(item, index) {
                item.no = index + 1; // Assign a 'no' based on the index
                delete item.id; // Remove 'id' field if necessary
                return item;
            });

            // Data Adapter for Unit
            var sourceUnit = {
                localdata: dataUnit,
                datatype: "array",
                datafields: [
                    { name: 'no', type: 'number' },
                    { name: 'unitCd', type: 'string' },
                    { name: 'description', type: 'string' }
                ]
            };

            var dataAdapterUnit = new $.jqx.dataAdapter(sourceUnit);

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
                    { text: 'No', datafield: 'no', width: '10%' },
                    { text: 'Unit Code', datafield: 'unitCd', width: '20%' },
                    { text: 'Unit', datafield: 'desciption', width: '70%' }
                ]
            });
        },
        error: function() {
            alert('Failed to load unit data.');
        }
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
      var locationId = $('#locationId').val();
      var locationName = $('#locationName').val();

      console.log(locationId);
      console.log(locationName);

      if(locationId && locationName) {
        $.ajax({
          url: '/api/master/locations', // Replace with your API endpoint
          method: 'POST',
          contentType: 'application/json', 
          data: JSON.stringify({
              locCd: locationId,
              location: locationName
          }),
          success: function(response) {
            // Handle success (for example, show a success message)
            alert('Location added successfully!');
            $('#addLocationModal').modal('hide'); // Close modal
            $("#jqxGrid1").jqxGrid('refresh');
          },
          error: function(xhr, status, error) {
            // Handle error (for example, show an error message)
            alert('Error: ' + error);
          }
        });
      } else {
        alert("Please fill in all fields.");
      }
    });

    // Save Item Code
    $('#saveItemCode').click(function () {
      var itemCode = $('#itemCode').val();
      var itemName = $('#itemName').val();
      var description = $('#descriptionItem').val();

      if(itemCode && itemName) {
        $.ajax({
          url: '/api/master/items', // Replace with your API endpoint
          method: 'POST',
          contentType: 'application/json', 
          data: JSON.stringify({
            itemCode: itemCode,
            itemName: itemName,
            desciption: description
          }),
          success: function(response) {
            // Handle success (for example, show a success message)
            alert('Item Code added successfully!');
            $('#addItemCodeModal').modal('hide'); // Close modal
            // Optionally, reload the grid or update the item code list here
          },
          error: function(xhr, status, error) {
            // Handle error (for example, show an error message)
            alert('Error: ' + error);
          }
        });
      } else {
        alert("Please fill in all fields.");
      }
    });

    // Save Unit
    $('#saveUnit').click(function () {
      var unitId = $('#unitId').val();
      var unitName = $('#unitName').val();

      if(unitId && unitName) {
        $.ajax({
          url: '/api/master/units', // Replace with your API endpoint
          method: 'POST',
          contentType: 'application/json', 
          data: JSON.stringify({
            unitCd: unitId,
            desciption: unitName
          }),
          success: function(response) {
            // Handle success (for example, show a success message)
            alert('Unit added successfully!');
            $('#addUnitModal').modal('hide'); // Close modal
            // Optionally, reload the grid or update the unit list here
          },
          error: function(xhr, status, error) {
            // Handle error (for example, show an error message)
            alert('Error: ' + error);
          }
        });
      } else {
        alert("Please fill in all fields.");
      }
    });
  });



</script>
