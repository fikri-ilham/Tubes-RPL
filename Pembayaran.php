<?php

namespace App\Controllers;

use App\Models\PembayaranModel;
use App\Models\PemesananModel;
use App\Models\ServerSideModel;
use CodeIgniter\Exceptions\PageNotFoundException;
use Config\Services;

class Pembayaran extends BaseController
{
    public function __construct()
    {
        // load Helper Form
        helper('form');

        $this->requestx = Services::request();
        // load Model
        // $this->pemesanan = new Pemesanan($this->requestx);
        $this->serverside_model = new ServerSideModel();
    }
    public function index()
    {
        $session = session();
        if ($session->get('role') == "ADMIN") {
            $hal = "admin/list_pembayaran";
        } else {
            $hal = "users/list_pembayaran";
        }
        $data = array(
            'id' => $session->get('id'),
            'User_Name' => $session->get('User_Name'),
            'nama_lengkap' => $session->get('nama_lengkap'),
            'role' => $session->get('role'),
            'current_uri' => $this->request->uri->getSegment(1),
        );
        return view($hal, $data);
    }

    public function ajax_list()
    {

        $session = session();
        if ($this->request->getMethod(true) === 'POST') {
            $column_order = array('IDPemesanan', 'IDPelanggan', 'IDAdmin');
            $column_search = array('IDPemesanan', 'IDPelanggan', 'IDAdmin');
            $order = array('TanggalPemesanan' => 'desc');

            if ($session->get('role') == "ADMIN") {
                $where = "";
            } else {
                $where = array('IDPelanggan' => $session->get('id'));
            }

            $lists = $this->serverside_model->get_datatables('v_pembayaran', $column_order, $column_search, $order, $where);
            $data = [];
            $no = $this->request->getPost("start");
            foreach ($lists as $list) {
                $no++;
                $row = [];
                $row[] = $no;
                $row[] = $list->IDPembayaran;
                $row[] = $list->IDPemesanan;
                $row[] = $list->Jumlah;
                $row[] = date('d M Y H:i:s', strtotime($list->TanggalPemesanan));
                $row[] = $list->Status_Pembayaran;
                $row[] = $list->IDPembayaran;
                $data[] = $row;
            }
            $output = [
                "draw" => $this->request->getPost('draw'),
                "recordsTotal" => $this->serverside_model->count_all('v_pembayaran', $where),
                "recordsFiltered" => $this->serverside_model->count_filtered('v_pembayaran', $column_order, $column_search, $order, $where),
                "data" => $data
            ];
            echo json_encode($output);
        }
    }

    public function read($kode)
    {
        $model = new PemesananModel($this->requestx);
        $session = session();
        if ($session->get('role') == "ADMIN") {
            $hal = "admin/detail_pembayaran";
        } else {
            $hal = "users/detail_pembayaran";
        }
        $this->data_session = array(
            'id' => $session->get('id'),
            'User_Name' => $session->get('User_Name'),
            'nama_lengkap' => $session->get('nama_lengkap'),
            'role' => $session->get('role'),
            'current_uri' => $this->request->uri->getSegment(1),
        );
        $this->data_session['pengajuan'] = $model->searchData(array('IDPembayaran' => $kode));
        if ($this->data_session['pengajuan']->HariPengerjaan == '6') {
            $maxpembayaran = date('d M Y H:i:s', strtotime('+6 hours', strtotime($this->data_session['pengajuan']->TanggalPemesanan)));
        } else if ($this->data_session['pengajuan']->HariPengerjaan == '48') {
            $maxpembayaran = date('d M Y H:i:s', strtotime('+48 hours', strtotime($this->data_session['pengajuan']->TanggalPemesanan)));
        } else if ($this->data_session['pengajuan']->HariPengerjaan == '72') {
            $maxpembayaran = date('d M Y H:i:s', strtotime('+72 hours', strtotime($this->data_session['pengajuan']->TanggalPemesanan)));
        } else {
            $maxpembayaran = 0;
        }

        $this->data_session['pengajuan']->maxPembayaran = $maxpembayaran;
        if (!$this->data_session['pengajuan']) {
            throw PageNotFoundException::forPageNotFound();
        }
        return view($hal, $this->data_session);
    }

    public function update($kode)
    {
        $model = new PembayaranModel($this->requestx);
        $data = array(
            "Status_Pembayaran" => $this->request->getVar('Status_Pembayaran'),
        );
        $model->updateData($kode, $data);
        return redirect()->to('/pembayaran');
    }
}
