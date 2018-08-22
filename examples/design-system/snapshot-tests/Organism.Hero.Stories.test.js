
    const tree = `<div>
    <div class="snapshot" id="Default">
        <section class="hero is-primary is-medium">
            <div class="hero-body">
                <div class="container">
                    <h1 class="title">
                        Lorem
                    </h1>
                    <h2 class="subtitle">
                        Ipsum
                    </h2>
                </div>
                <div style="marginTop:1em;">
                    <a class="button is-primary is-inverted">
                        Dolor
                    </a>
                </div>
            </div>
        </section>
    </div>
</div>`;
    test("Organism.Hero.Stories", () => {
      expect(tree).toMatchSnapshot();
    });
    