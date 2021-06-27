<?php

namespace App\Models;

use CodeIgniter\Model;
use CodeIgniter\HTTP\RequestInterface;

class PembayaranModel extends Model
{
    protected $table = 'pembayaran';
    protected $primaryKey = 'IDPembayaran';
    protected $allowedFields = ['IDPembayaran', 'IDPemesanan', 'IDDelivery', 'Jumlah', 'Status_Pembayaran'];

    protected $column_order = array('IDPembayaran', 'IDPemesanan', 'Status_Pembayaran');
    protected $column_search = array('IDPembayaran', 'IDPemesanan', 'Status_Pembayaran');
    protected $order = array('IDPembayaran' => 'desc');
    protected $request;

    function __construct(RequestInterface $request)
    {
        parent::__construct();
        $this->dt = $this->db->table('v_pembayaran');
        $this->requestx = $request;
    }

    public function generateCode()
    {
        $kode = $this->checkCode();
        $kodetampil  = "INV" . sprintf("%04s", $kode);
        return $kodetampil;
    }

    public function checkCode()
    {
        $query = $this->db->query("SELECT MAX(IDPembayaran) as kode FROM pembayaran");
        if (!is_null($query->getNumRows())) {
            $data = $query->getRow();
            $nourut = substr($data->kode, 3, 4);
            $kode = $nourut + 1;
        } else {
            $kode = 1;
        }
        return $kode;
    }

    public function searchData($search)
    {
        return $this->db->table('v_pembayaran')->getWhere($search)->getRow();
    }

    public function updateData($kode, $data)
    {
        return $this->db->table($this->table)->update($data, ['IDPembayaran' => $kode]);
    }
}
