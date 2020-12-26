<template>
    <div id="app" class="col">
        <div class="row">
            <NavBar class="col-sm-12 col-md-3 col-lg-3 col-xl-2 nav-bar" id="nav-bar"
                    :class="activeNav ? 'fadein': 'fadeout'"/>
            <router-view id="router-view" class="col col-lg-9 col-xl-10 "
                         :class="activeNav ? 'col-md-9': ''" @click="routerClicked()"/>

            <b-button v-if="screenWidthSM || screenWidthMD" class="nav-button" v-on:click="toggleNav()">
                <font-awesome-icon :icon="['fas', 'bars']" :class="activeNav ? 'rotate': 'norotate'"/>
            </b-button>
        </div>
    </div>
</template>

<script>
    import NavBar from "@/components/NavBar";
    import {EventBus} from "@/main";

    export default {
        name: 'App',
        components: {
            NavBar
        },
        data() {
            return {activeNav: false, screenWidthSM: false,  screenWidthMD: false}
        },
        created() {
            EventBus.$on('loaded', () => {
                this.foldNavMobile()
            });
            EventBus.$on('nav-item-selected', () => {
                this.foldNavMobile()
            });
            this.onResize()
        },
        methods: {
            toggleNav() {
                this.activeNav = !this.activeNav;
            },
            foldNavMobile() {
                if (this.screenWidthSM) this.activeNav = false;
            },
            onResize() {
                if (window.innerWidth < 768) {
                    this.screenWidthSM = true
                } else  if (window.innerWidth < 992) {
                    this.screenWidthMD = true
                } else {
                    this.screenWidthSM = false
                    this.screenWidthMD = false
                    this.activeNav = true
                }
            },
            routerClicked() {
                if (this.activeNav) this.activeNav = !this.activeNav
            }
        },
        mounted() {
            window.addEventListener('resize', () => {
                this.onResize()
            })
        }
    }
</script>

<style lang="stylus">
    json('./assets/colors.json')

    ul
        display inline
        list-style-type none !important
    #app


        font-family: "DejaVu Serif";
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        text-align: center;
        color: primary;
        background-color #e5d9d;
        border-color #A47864;
        width: 100vw;
        height 100vh
        overflow hidden

        .nav-bar
            transition ease-in-out .3s
            border-right 2px solid #A47864;

        #router-view
            transition ease-in-out .3s

        #nav-bar.fadein
            transform translateX(0%)

        #nav-bar.fadeout
            transform translateX(-100%)
            opacity 0.3

        .nav-button
            top .5rem
            left .5rem
            position absolute
            z-index: 97;

        .rotate {
            transform: rotate(180deg);
            transition: ease-in-out .35s;
        }

        .norotate {
            transform: rotate(0deg);
            transition: ease-in-out .35s;
        }

        @media (max-width: 992px)
            #router-view
                right 0
                position absolute

            #nav-bar
                z-index 95

        @media (max-width: 768px)

            #router-view.fadein
                transform translateX(100%)

            #router-view.fadeout
                display none


    ::-webkit-scrollbar {
        width: .3em;
    }

    ::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
        background-color: #F5F5F5;
    }

    ::-webkit-scrollbar-thumb {
        background-color: darkgrey;
        outline: 1px solid slategrey;
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
    }

</style>