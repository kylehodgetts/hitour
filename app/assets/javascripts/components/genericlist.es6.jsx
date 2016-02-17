class GenericList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      items: this.props.items
    };
  }

  render () {
    return (
      <div>
        <div className="collection">
          {this.state.items.map(function(item) {
            return(
              <div key={item.id} className="collection-item">
                <div>
                  {item.data}
                  <a href="#!" className="secondary-content">
                    <i className="material-icons">delete_forever</i>
                  </a>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    );
  }
}

GenericList.displayName = "List";
GenericList.propTypes = {
  items: React.PropTypes.array.isRequired
}
