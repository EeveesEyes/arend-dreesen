<template>
    <div class="container">
        <div class="row mb-4 shadow align-middle cell-header">
            <div class="col-8 mt-5 cell-text">
                <h1 class="row">Arend Dreesen</h1>
                <div class="row">Heimatdichter</div>
                <div class="row">1883 - 1928</div>
            </div>
            <div class="col-4 cropped">
                <img class="cell-image portrait" src="http://previous.bildindex.de/bilder/m/fmd496648"
                     alt="Arend Dreesen">
            </div>
        </div>
        <div class="row mb-4 pl-lg-5 pr-lg-5">
            <div class="col-lg-3 col-4 pl-0">
                <img class="cell-image"
                     src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Poppe_Folkerts_Portrait.jpg/800px-Poppe_Folkerts_Portrait.jpg"
                     alt="Poppe Folkerts">
            </div>
            <div class="col-lg-9 col-8 shadow cell-text d-flex flex-column">
                <h3 class="row">Biographie</h3>
                <div class="row">* 1883 Norden + 17.11.1928 Norden Lorem ipsum dolor sit amet, consetetur sadipscing
                    elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat
                </div>
                <div class="row mt-auto cell-caption">
                    <span>Poppe Folkerts in den 1930ern</span>
                    <a class="ml-2" href="https://de.wikipedia.org/wiki/Poppe_Folkerts" target="_blank">
                        <font-awesome-icon :icon="['fas', 'external-link-alt']"/>
                    </a>
                </div>
            </div>
        </div>
        <div class="row mb-4 pl-lg-5 pr-lg-5">
            <div class="col-lg-9 col-7 shadow cell-text d-flex flex-column">
                <h3 class="row">Poppe Folkers</h3>
                <div class="row">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor
                    invidunt ut labore et dolore magna aliquyam erat
                </div>
                <div class="row mt-auto justify-content-end cell-caption">
                    <span>Poppe Folkerts in den 1930ern</span>
                    <a class="ml-2" href="https://de.wikipedia.org/wiki/Poppe_Folkerts" target="_blank">
                        <font-awesome-icon :icon="['fas', 'external-link-alt']"/>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-5 pr-0">
                <img class="cell-image"
                     src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Poppe_Folkerts_Portrait.jpg/800px-Poppe_Folkerts_Portrait.jpg"
                     alt="Poppe Folkerts">
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Home"
    }
</script>

<style lang="stylus">
    json('../assets/colors.json')

    .container
        max-height 100vh
        overflow-y auto
        overflow-x hidden

    .cropped
        overflow: hidden;
        height 18rem;

        .portrait
            margin: 0 0 0 0;

    .cell-text
        padding 2rem !important

    .cell-image
        //height 30% vh
        height:100%;
        width 100%
        object-fit: cover;

    .cell-caption
        font-size small
        color: light

        a
            color: light

    .cell-header
        background-color light

    @media (max-width: 768px)
        .container
            height 100vh

</style>