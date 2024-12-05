<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  .select2-container .select2-selection--single {
      height: 38px;
  }

  .card-body {
    max-height: 400px;  /* Atur tinggi maksimum untuk card body */
    overflow-y: auto;   /* Menambahkan scroll jika konten melebihi tinggi */
    padding: 0px;
  }

  .row {
    margin-bottom: 10px; /* Kurangi margin antar row */
  }

  .col-md-12, .col-md-6 {
    padding: 0px; /* Mengurangi padding di dalam kolom */
  }

  .card {
    margin-bottom: 5px 10px; /* Mengurangi jarak antar card */
  }

  .card-header {
    padding: 5px 10px; /* Mengurangi padding di header */
  }

  #columntablejqxGrid1 .jqx-checkbox-default, 
  #columntablejqxGrid2 .jqx-checkbox-default, 
  #columntablejqxGrid3 .jqx-checkbox-default {
    display: none;
  }
</style>

<section class="content">
  <div class="row">
    <!-- Kolom 1: ItemCode -->
    <div class="col-md-12">
      <div class="card card-secondary">
        <div class="card-header">
          <h3 class="card-title">ItemCode</h3>
          <div class="card-tools">
            <button type="button" id="AddItemCode" class="btn btn-primary btn-sm">
              <i class="fas fa-plus"></i> Add
            </button>
            <button type="button" id="jqxGrid2Edit" class="btn btn-success btn-sm" disabled>
              <i class="fas fa-edit"></i> Edit
            </button>
            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
              <i class="fas fa-minus"></i>
            </button>
          </div>
        </div>
        <div class="card-body">
          <div id="jqxGrid2" class="jqxGrid"></div>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <!-- Kolom 2: Location -->
    <div class="col-md-6">
      <div class="card card-secondary">
        <div class="card-header">
          <h3 class="card-title">Location</h3>
          <div class="card-tools">
            <button type="button" id="addLoc" class="btn btn-primary btn-sm">
              <i class="fas fa-plus"></i> Add
            </button>
            <button type="button" id="jqxGrid1Edit" class="btn btn-success btn-sm" disabled>
              <i class="fas fa-edit"></i> Edit
            </button>
            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
              <i class="fas fa-minus"></i>
            </button>
          </div>
        </div>
        <div class="card-body">
          <div id="jqxGrid1" class="jqxGrid"></div>
        </div>
      </div>
    </div>

    <!-- Kolom 3: Unit -->
    <div class="col-md-6">
      <div class="card card-secondary">
        <div class="card-header">
          <h3 class="card-title">Unit</h3>
          <div class="card-tools">
            <button type="button" id="addUnit" class="btn btn-primary btn-sm">
              <i class="fas fa-plus"></i> Add
            </button>
            <button type="button" id="jqxGrid3Edit" class="btn btn-success btn-sm" disabled>
              <i class="fas fa-edit"></i> Edit
            </button>
            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
              <i class="fas fa-minus"></i>
            </button>
          </div>
        </div>
        <div class="card-body">
          <div id="jqxGrid3" class="jqxGrid"></div>
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
        <form id="addLocationForm" data-mode="add">
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
        <form id="addItemCodeForm" data-mode="add">
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
          <div class="mb-3">
            <label for="partNum" class="form-label">Part Number</label>
            <input type="text" class="form-control" id="partNum" required>
          </div>
          <div class="form-group">
            <label for="unit">Unit</label>
            <select class="form-control select2" id="unit" style="width: 100%;" name="unit" required>
                <option value="" selected>Select Unit</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="safetyStock" class="form-label">Safety Stock</label>
            <input type="text" class="form-control" id="safetyStock" required>
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
        <form id="addUnitForm" data-mode="add">
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


<script>
  $(document).ready(function () {
    $('.select2').select2();

    // Mengambil data Unit
    $.ajax({
        url: '${pageContext.request.contextPath}/master/api/units',
        type: 'GET',
        success: function (data) {
            let unitDropdownAdd = $('#unit');  // Untuk modal Add

            data.forEach(function (unit) {
                unitDropdownAdd.append('<option value="' + unit.unitCd + '">' + unit.unitCd + ' - ' + unit.description + '</option>');
            });
        },
        error: function (err) {
            console.error("Error fetching units:", err);
        }
    });

    // Initialize jqxGrid for Location, Item, and Unit
    function initializeGrid(gridId, columns, dataAdapter) {
        $(gridId).jqxGrid({
            width: '100%',
            height: 350,  /* Mengatur tinggi grid */
            autoheight: false,  /* Nonaktifkan autoheight */
            pageable: true,
            pagesize: 10, // Show 10 rows per page
            source: dataAdapter,
            columnsresize: true,
            pagerMode: 'default',
            selectionmode: 'checkbox',
            columns: columns,
            sortable: true,
            showfilterrow: true,
            filterable: true,
        });
    }

    // Define columns for Location, Item, and Unit
    var locationColumns = [
        { text: 'No', datafield: 'no', width: '6%' },
        { text: 'Loc Code', datafield: 'locCd', width: '20%' },
        { text: 'Location', datafield: 'location', width: '70%' }
    ];

    var itemColumns = [
        { text: 'No', datafield: 'no', width: '3%' },
        { text: 'Item Code', datafield: 'itemCode', width: '20%' },
        { text: 'Name', datafield: 'itemName', width: '20%' },
        { text: 'Description', datafield: 'description', width: '20%' },
        { text: 'Part Number', datafield: 'partNum', width: '20%' },
        { text: 'Safety Stock', datafield: 'safetyStock', width: '10%' },
        { text: 'Unit', datafield: 'unitCd', width: '5%' }
    ];

    var unitColumns = [
        { text: 'No', datafield: 'no', width: '6%' },
        { text: 'Unit Code', datafield: 'unitCd', width: '20%' },
        { text: 'Unit', datafield: 'description', width: '70%' }
    ];

    // Define functions to handle data AJAX response and update grid
    function handleDataResponse(url, gridId, columns) {
        $.ajax({
            url: url,
            method: 'GET',
            success: function(data) {
                // Modify the response to replace 'id' with 'no'
                data = data.map(function(item, index) {
                    item.no = index + 1; // Assign a 'no' based on the index
                    delete item.id; // Remove 'id' field if necessary
                    return item;
                });

                // Data Adapter
                var source = {
                    localdata: data,
                    datatype: "array",
                    datafields: columns.map(function(col) {
                        return { name: col.datafield, type: 'string' };
                    })
                };

                var dataAdapter = new $.jqx.dataAdapter(source);

                // Initialize the jqxGrid with the new dataAdapter
                initializeGrid(gridId, columns, dataAdapter);
                
                // Handle row select
                $(gridId).on('rowselect', function (event) {
                    var rowsSelected = $(gridId).jqxGrid('getselectedrowindexes');
                    if (rowsSelected.length > 1) {
                        // Unselect previously selected rows
                        $(gridId).jqxGrid('unselectrow', rowsSelected[0]);
                    }

                    // Enable edit button if one row is selected
                    $(gridId + 'Edit').prop('disabled', rowsSelected.length === 0);
                });
            },
            error: function() {
                alert('Failed to load data.');
            }
        });
    }

    // Handle AJAX requests for different grids
    handleDataResponse('/master/api/locations', '#jqxGrid1', locationColumns);
    handleDataResponse('/master/api/items', '#jqxGrid2', itemColumns);
    handleDataResponse('/master/api/units', '#jqxGrid3', unitColumns);


    // Open modal when clicking 'Add' button
    $('#addLoc').click(function () {
        $('#addLocationModal').modal('show');
        $('#addLocationForm').attr('data-mode', 'add');
        $('#locationId').prop('disabled', false); // Enable itemCode field
        $('#addLocationForm')[0].reset(); // Clear form inputs
    });

    $('#AddItemCode').click(function () {
      // Set modal mode to add
      $('#addItemCodeModal').modal('show');
      $('#addItemCodeForm').attr('data-mode', 'add'); // Set mode to add
      $('#itemCode').prop('disabled', false); // Enable itemCode field
      $('#addItemCodeForm')[0].reset(); // Clear form inputs
    });

    $('#addUnit').click(function () {
        $('#addUnitModal').modal('show');
        $('#addUnitForm').attr('data-mode', 'add');
        $('#unitId').prop('disabled', false); // Enable itemCode field
        $('#addUnitForm')[0].reset(); // Clear form inputs
    });

    // Open Edit Modal
    $('#jqxGrid2Edit').click(function () {
      var selectedRowIndex = $("#jqxGrid2").jqxGrid('getselectedrowindex');
      if (selectedRowIndex === -1) {
        alert('Please select a row to edit.');
        return;
      }

      // Get row data
      var rowData = $("#jqxGrid2").jqxGrid('getrowdata', selectedRowIndex);

      // Populate the modal with row data
      $('#itemCode').val(rowData.itemCode);
      $('#itemName').val(rowData.itemName);
      $('#descriptionItem').val(rowData.description);
      $('#partNum').val(rowData.partNum);
      $('#safetyStock').val(rowData.safetyStock);

      // Set modal mode to edit
      $('#addItemCodeModal').modal('show');
      $('#addItemCodeForm').attr('data-mode', 'edit'); // Set mode to edit
      $('#itemCode').prop('disabled', true); // Disable itemCode field
    });

    // Open Edit Location Modal
    $('#jqxGrid1Edit').click(function () {
      var selectedRowIndex = $("#jqxGrid1").jqxGrid('getselectedrowindex');
      if (selectedRowIndex === -1) {
        alert('Please select a row to edit.');
        return;
      }

      // Get row data
      var rowData = $("#jqxGrid1").jqxGrid('getrowdata', selectedRowIndex);
      console.log(rowData);
      // Populate the modal with row data
      $('#locationId').val(rowData.locCd);
      $('#locationName').val(rowData.location);

      // Set modal mode to edit
      $('#addLocationModal').modal('show');
      $('#addLocationForm').attr('data-mode', 'edit'); // Set mode to edit
      $('#locationId').prop('disabled', true); // Disable itemCode field
    });

    // Open Edit Location Modal
    $('#jqxGrid3Edit').click(function () {
      var selectedRowIndex = $("#jqxGrid3").jqxGrid('getselectedrowindex');
      if (selectedRowIndex === -1) {
        alert('Please select a row to edit.');
        return;
      }

      // Get row data
      var rowData = $("#jqxGrid3").jqxGrid('getrowdata', selectedRowIndex);
      console.log(rowData);
      // Populate the modal with row data
      $('#unitId').val(rowData.unitCd);
      $('#unitName').val(rowData.description);

      // Set modal mode to edit
      $('#addUnitModal').modal('show');
      $('#addUnitForm').attr('data-mode', 'edit'); // Set mode to edit
      $('#unitId').prop('disabled', true); // Disable itemCode field
    });

    // Save Location
    $('#saveLocation').click(function () {
      var mode = $('#addLocationForm').attr('data-mode'); // Get current mode (add or edit)
      var locationId = $('#locationId').val();
      var locationName = $('#locationName').val();

      if(locationId && locationName) {
        $.ajax({
          url: '/master/api/locations', // Replace with your API endpoint
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
           
            // Refresh the jqxGrid for locations
            handleDataResponse('/master/api/locations', '#jqxGrid1', locationColumns);
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
      var mode = $('#addItemCodeForm').attr('data-mode'); // Get current mode (add or edit)
      var itemCode = $('#itemCode').val();
      var itemName = $('#itemName').val();
      var description = $('#descriptionItem').val();
      var partNum = $('#partNum').val();
      var unitCd = $('#unit').val();
      var safetyStock = $('#safetyStock').val();

      if (itemCode && itemName) {
        var apiUrl = '/master/api/items';
        var method = 'POST';


        $.ajax({
          url: apiUrl,
          method: method,
          contentType: 'application/json',
          data: JSON.stringify({
            itemCode: itemCode,
            itemName: itemName,
            description: description,
            partNum: partNum,
            unitCd: unitCd,
            safetyStock: safetyStock
          }),
          success: function (response) {
            alert('Item Code ' + (mode === 'add' ? 'added' : 'updated') + ' successfully!');
            $('#addItemCodeModal').modal('hide'); // Close modal
            // Optionally, reload the grid or update the item code list here
            handleDataResponse('/master/api/items', '#jqxGrid2', itemColumns);
          },
          error: function (xhr, status, error) {
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
          url: '/master/api/units', // Replace with your API endpoint
          method: 'POST',
          contentType: 'application/json', 
          data: JSON.stringify({
            unitCd: unitId,
            description: unitName
          }),
          success: function(response) {
            // Handle success (for example, show a success message)
            alert('Unit added successfully!');
            $('#addUnitModal').modal('hide'); // Close modal
            // Optionally, reload the grid or update the unit list here
            handleDataResponse('/master/api/units', '#jqxGrid3', unitColumns);
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
