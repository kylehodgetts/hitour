class SinglePoint extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      data: this.props.data
    };
  }

  render() {
    console.log(this.state.data);
    return (
      <div>
        <div className="row">
          <div className="col s6">
          </div>
          <div className="col s6">
            <h2>{this.props.pointName}</h2>
          </div>
        </div>
        <div className="row">
          <ul className="collapsible" data-collapsible="accordion">
            {this.state.data.map(function(datum){
              return (
                <li key={datum.id}>
                  <div className="collapsible-header">{datum.title}</div>
                  <div className="collapsible-body">
                    <p>{datum.description}</p>
                  </div>
                </li>
              );
            })}
          </ul>
        </div>
      </div>
    );
  }
}
SinglePoint.displayName = "SinglePoint";
SinglePoint.propTypes = {
  qrCode: React.PropTypes.any,
  pointName: React.PropTypes.string.isRequired,
  data: React.PropTypes.array.isRequired
}
