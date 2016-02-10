class Header extends React.Component {
  render () {
    return (
      <nav>
        <div className="nav-wrapper  blue darken-1">
          <a href="#!" id="logo" className="brand-logo center">hiTour</a>
          <a href="#" data-activates="mobile-nav" className="button-collapse"><i className="material-icons">menu</i></a>
          <ul className="right hide-on-med-and-down">
            <Navlist />
          </ul>
          <ul className="side-nav" id="mobile-nav">
            <Navlist />
          </ul>
        </div>
      </nav>

    );
  }
}

Header.displayName = "Header";
Header.propTypes = {

}