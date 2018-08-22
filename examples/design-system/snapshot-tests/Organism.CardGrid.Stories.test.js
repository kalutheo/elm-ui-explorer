
    const tree = `<div>
    <div class="snapshot" id="Default">
        <div style="padding:3em;">
            <div class="tile is-ancestor">
                <div class="tile is-parent">
                    <div class="card">
                        <div class="card-content">
                            <div class="media">
                                <div class="media-left">
                                    <figure class="image is-48x48">
                                        <img alt="Image" src="http://bulma.io/images/placeholders/96x96.png">
                                    </figure>
                                </div>
                                <div class="media-content">
                                    <p class="title is-4">
                                        Lorem ipsum
                                    </p>
                                    <p class="subtitle is-6">
                                        @lorem
                                    </p>
                                </div>
                            </div>
                            <div class="content">
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      Phasellus nec iaculis mauris.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tile is-parent">
                    <div class="card">
                        <div class="card-content">
                            <div class="media">
                                <div class="media-left">
                                    <figure class="image is-48x48">
                                        <img alt="Image" src="http://bulma.io/images/placeholders/96x96.png">
                                    </figure>
                                </div>
                                <div class="media-content">
                                    <p class="title is-4">
                                        Lorem ipsum
                                    </p>
                                    <p class="subtitle is-6">
                                        @lorem
                                    </p>
                                </div>
                            </div>
                            <div class="content">
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      Phasellus nec iaculis mauris.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tile is-ancestor">
                <div class="tile is-parent">
                    <div class="card">
                        <div class="card-content">
                            <div class="media">
                                <div class="media-left">
                                    <figure class="image is-48x48">
                                        <img alt="Image" src="http://bulma.io/images/placeholders/96x96.png">
                                    </figure>
                                </div>
                                <div class="media-content">
                                    <p class="title is-4">
                                        Lorem ipsum
                                    </p>
                                    <p class="subtitle is-6">
                                        @lorem
                                    </p>
                                </div>
                            </div>
                            <div class="content">
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      Phasellus nec iaculis mauris.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tile is-parent">
                    <div class="card">
                        <div class="card-content">
                            <div class="media">
                                <div class="media-left">
                                    <figure class="image is-48x48">
                                        <img alt="Image" src="http://bulma.io/images/placeholders/96x96.png">
                                    </figure>
                                </div>
                                <div class="media-content">
                                    <p class="title is-4">
                                        Lorem ipsum
                                    </p>
                                    <p class="subtitle is-6">
                                        @lorem
                                    </p>
                                </div>
                            </div>
                            <div class="content">
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      Phasellus nec iaculis mauris.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>`;
    test("Organism.CardGrid.Stories", () => {
      expect(tree).toMatchSnapshot();
    });
    