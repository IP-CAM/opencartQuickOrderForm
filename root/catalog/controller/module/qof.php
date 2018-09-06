<?php 
class ControllerModuleQof extends Controller
{
    protected function index($setting)
    {
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/qof.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/qof.tpl';
        } else {
            $this->template = 'default/template/module/qof.tpl';
        }

        $this->data['page_link'] = $setting['page_link'];
        $this->data['settings_per_page'] = $setting['settings_per_page'];

        $this->language->load('module/qof');
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->render();
    }
}
?>