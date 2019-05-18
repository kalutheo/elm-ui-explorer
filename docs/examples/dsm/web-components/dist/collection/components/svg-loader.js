import SVGInjector from "svg-injector";
export class SvgLoader {
    updateImage() {
        if (this.imageElement) {
            const newImage = new Image();
            newImage.src = this.url;
            newImage.style.fill = this.color;
            newImage.style.width = this.width + "px";
            while (this.imageElement.firstChild) {
                this.imageElement.removeChild(this.imageElement.firstChild);
            }
            this.imageElement.append(newImage);
            SVGInjector(newImage);
        }
    }
    componentDidLoad() {
        this.updateImage();
    }
    componentDidUpdate() {
        this.updateImage();
    }
    render() {
        return h("div", { ref: el => (this.imageElement = el) });
    }
    static get is() { return "svg-loader"; }
    static get properties() { return {
        "color": {
            "type": String,
            "attr": "color"
        },
        "url": {
            "type": String,
            "attr": "url"
        },
        "width": {
            "type": String,
            "attr": "width"
        }
    }; }
}
