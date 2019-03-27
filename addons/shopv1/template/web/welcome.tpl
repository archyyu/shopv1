{include file="common/header.tpl"}
<div>welcome</div>

<div>
    <button id="success" class="btn btn-success" onclick="clickSuccess()">success tips</button>
    <button id="info" class="btn btn-info" onclick="clickInfo()">info tips</button>
    <button id="danger" class="btn btn-danger" onclick="clickError()">info tips</button>
</div>

<script>
    function clickSuccess() {
        new Noty({
            text: 'NOTY - a dependency-free notification library!',
            type: 'success',
            theme: 'metroui',
            animation: {
                open: 'animated bounceInRight', // Animate.css class names
                close: 'animated bounceOutRight' // Animate.css class names
            },
            progressBar: true,
            timeout: 3000
        }).show();
    }
    function clickInfo() {
        new Noty({
            text: 'NOTY - a dependency-free notification library!',
            type: 'info',
            theme: 'metroui',
            layout: 'bottomRight',
            animation: {
                open: 'animated bounceInRight', // Animate.css class names
                close: 'animated bounceOutRight' // Animate.css class names
            },
            progressBar: true,
            timeout: 3000
        }).show();
    }
    function clickError() {
        new Noty({
            text: 'NOTY - a dependency-free notification library!',
            type: 'error',
            theme: 'metroui',
            layout: 'top',
            animation: {
                open: 'animated bounceInRight', // Animate.css class names
                close: 'animated bounceOutRight' // Animate.css class names
            }
        }).show();
        
    }
</script>
{include file="common/footer.tpl"}