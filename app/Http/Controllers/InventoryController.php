<?php

namespace App\Http\Controllers;

use App\Constants\InventoryConsts;
use App\Models\Inventory;
use App\Models\Parameter;
use App\Models\User;
use Illuminate\Http\Request;

class InventoryController extends Controller
{
    public function index()
    {
        $inventories = Inventory::with(["getStatus", "getUser"])->get();

        return response()->json(["inventories" => $inventories]);
    }

    public function store(Request $request)
    {
        $inputs = $request->all();

        $statud_id_in_process = Parameter::getParameterByKey(InventoryConsts::INVENTORY_STATUS_IN_PROCESS)->id;

        $inventory = new Inventory($inputs);
        $inventory->id_status = $statud_id_in_process;
        $inventory->id_user = User::getAuthUserId();
        $inventory->save();

        LogController::store($request, InventoryConsts::INVENTORY_APP_KEY, InventoryConsts::INVENTORY_MESSAGE_STORE_LOG, $inventory->id);

        return response()->json([
            'status' => true,
            'message' => InventoryConsts::INVENTORY_MESSAGE_STORE_SUCCESS,
            'inventory' => $inventory
        ], 200);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
