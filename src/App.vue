<template>
    <div id="app" class="col">
        <div class="row">
            <NavBar class="col-sm-12 col-md-12 col-lg-3 col-xl-2 nav-bar" id="nav-bar" :class="activeNav ? 'fadein': 'fadeout'"/>
            <router-view id="router-view" class="col col-lg-9 col-xl-10 " :class="activeNav ? 'fadein': 'fadeout'"/>

            <b-button v-if="mobile" class="nav-button" v-on:click="toggleNav()">
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
            return {activeNav: true, mobile: false}
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
                if (this.mobile)  this.activeNav = false;
            },
            onResize() {
                if (window.innerWidth < 992) {
                    this.mobile = true
                } else {
                    this.mobile = false
                    this.activeNav = true
                }
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
    #app
        // COLORS:
        // #E5D9D3
        // #D9A6A1
        // #ADBED3
        // #E5D68E
        // #A47864


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
            right .5rem
            position absolute

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
                position absolute

            #router-view.fadein
                transform translateX(100%)


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