
    const tree = `<div>
    <div class="snapshot" id="Default">
        <div style="backgroundColor:#CCC;">
            <nav class="navbar" aria-label="main navigation" role="navigation">
                <div class="navbar-brand">
                    <a class="navbar-item" href="">
                        <img alt="Bulma: a modern CSS framework based on Flexbox" height="28" src="http://bulma.io/images/bulma-logo.png" width="112">
                    </a>
                    <button class="button navbar-burger" data-target="navMenu">
                        <span>
                        </span>
                        <span>
                        </span>
                        <span>
                        </span>
                    </button>
                </div>
                <div class="navbar-menu" id="navMenubd-example">
                    <a class="navbar-item ">
                        <span>
                            Home
                        </span>
                    </a>
                    <a class="navbar-item ">
                        <span>
                            About
                        </span>
                    </a>
                </div>
            </nav>
            <div>
                <section class="hero is-primary is-medium">
                    <div class="hero-body">
                        <div class="container">
                            <h1 class="title">
                                Welcome to the home
                            </h1>
                            <h2 class="subtitle">
                                A place to manage your contacts
                            </h2>
                        </div>
                        <div style="marginTop:1em;">
                            <a class="button is-primary is-inverted">
                                Dicover now >>
                            </a>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
</div>`;
    test("Page.Home.Stories", () => {
      expect(tree).toMatchSnapshot();
    });
    