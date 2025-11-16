{#
 # Initial DHCP-DDNS UI view
 #}

<script>
    $( document ).ready(function() {
        const data_get_map = {'frm_generalsettings':"/api/kea/dhcpddns/get"};
        mapDataToFormUI(data_get_map).done(function(data){
            updateServiceControlUI('kea');
        });

        $("#{{formGridForwardDomain['table_id']}}" ).UIBootgrid(
            {   search:'/api/kea/dhcpddns/search_forward_domain',
                get:'/api/kea/dhcpddns/get_forward_domain/',
                set:'/api/kea/dhcpddns/set_forward_domain/',
                add:'/api/kea/dhcpddns/add_forward_domain/',
                del:'/api/kea/dhcpddns/del_forward_domain/'
            }
        );

        $("#{{formGridReverseDomain['table_id']}}" ).UIBootgrid(
            {   search:'/api/kea/dhcpddns/search_reverse_domain',
                get:'/api/kea/dhcpddns/get_reverse_domain/',
                set:'/api/kea/dhcpddns/set_reverse_domain/',
                add:'/api/kea/dhcpddns/add_reverse_domain/',
                del:'/api/kea/dhcpddns/del_reverse_domain/'
            }
        );

        $("#{{formGridTsigKey['table_id']}}" ).UIBootgrid(
            {   search:'/api/kea/dhcpddns/search_tsig_key',
                get:'/api/kea/dhcpddns/get_tsig_key/',
                set:'/api/kea/dhcpddns/set_tsig_key/',
                add:'/api/kea/dhcpddns/add_tsig_key/',
                del:'/api/kea/dhcpddns/del_tsig_key/'
            }
        );

        $("#{{formGridDnsServer['table_id']}}" ).UIBootgrid(
            {   search:'/api/kea/dhcpddns/search_dns_server',
                get:'/api/kea/dhcpddns/get_dns_server/',
                set:'/api/kea/dhcpddns/set_dns_server/',
                add:'/api/kea/dhcpddns/add_dns_server/',
                del:'/api/kea/dhcpddns/del_dns_server/'
            }
        );

        $("#reconfigureAct").SimpleActionButton({
            onPreAction: function() {
                const dfObj = new $.Deferred();
                saveFormToEndpoint("/api/kea/dhcpddns/set", 'frm_generalsettings', function () { dfObj.resolve(); }, true, function () { dfObj.reject(); });
                return dfObj;
            },
            onAction: function(data, status) {
                updateServiceControlUI('kea');
            }
        });
    });
</script>

<ul class="nav nav-tabs" data-tabs="tabs" id="maintabs">
    <li class="active"><a data-toggle="tab" href="#settings" id="tab_settings">{{ lang._('Settings') }}</a></li>
    <li><a data-toggle="tab" href="#forward-domains" id="tab_forward"> {{ lang._('Forward Domains') }} </a></li>
    <li><a data-toggle="tab" href="#reverse-domains" id="tab_reverse"> {{ lang._('Reverse Domains') }} </a></li>
    <li><a data-toggle="tab" href="#tsig-keys" id="tab_tsig"> {{ lang._('TSIG Keys') }} </a></li>
    <li><a data-toggle="tab" href="#dns-servers" id="tab_dns"> {{ lang._('DNS Servers') }} </a></li>
    </ul>
<div class="tab-content content-box">
    <div id="settings"  class="tab-pane fade in active">
        {{ partial("layout_partials/base_form",['fields':formGeneralSettings,'id':'frm_generalsettings'])}}
    </div>
    <div id="forward-domains" class="tab-pane fade in">
        {{ partial('layout_partials/base_bootgrid_table', formGridForwardDomain)}}
    </div>
    <div id="reverse-domains" class="tab-pane fade in">
        {{ partial('layout_partials/base_bootgrid_table', formGridReverseDomain)}}
    </div>
    <div id="tsig-keys" class="tab-pane fade in">
        {{ partial('layout_partials/base_bootgrid_table', formGridTsigKey)}}
    </div>
    <div id="dns-servers" class="tab-pane fade in">
        {{ partial('layout_partials/base_bootgrid_table', formGridDnsServer)}}
    </div>
</div>

{{ partial('layout_partials/base_apply_button', {'data_endpoint': '/api/kea/service/reconfigure'}) }}
{{ partial("layout_partials/base_dialog",['fields':formDialogForwardDomain,'id':formGridForwardDomain['edit_dialog_id'],'label':lang._('Edit Forward Domain')])}}
{{ partial("layout_partials/base_dialog",['fields':formDialogReverseDomain,'id':formGridReverseDomain['edit_dialog_id'],'label':lang._('Edit Reverse Domain')])}}
{{ partial("layout_partials/base_dialog",['fields':formDialogTsigKey,'id':formGridTsigKey['edit_dialog_id'],'label':lang._('Edit TSIG Key')])}}
{{ partial("layout_partials/base_dialog",['fields':formDialogDnsServer,'id':formGridDnsServer['edit_dialog_id'],'label':lang._('Edit DNS Server')])}}
