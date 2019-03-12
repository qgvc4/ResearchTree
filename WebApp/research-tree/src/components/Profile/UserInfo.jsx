import React, { Component } from 'react';
import { Avatar } from 'antd';

import {Majors} from '../../declaration/major';
import {Standings} from '../../declaration/standing';

export default class UserInfo extends Component {

    render() {
        return (
            <div>
                {this.props.user.image == null ? <Avatar size={100} icon="user"/> : <Avatar src={this.props.user.image}/>}
                <h3>{this.props.user.firstname + " " + this.props.user.lastname}</h3>
                {standingOptions(this.props.user.standing)}
                {majorOptions(this.props.user.majors)}
                <h4>{this.props.user.email}</h4>
            </div>
        )
    }
}

function majorOptions(majors) {
    var majorView = [];
    if(majors != null && majors !== undefined){
        majors.forEach( (elem, index) => {
            majorView.push(<h4 key={index}>{Majors[elem]}</h4>)
        });
        return majorView;
    }
    else{
        return undefined;
    }
  }
  
  function standingOptions(standing) {
    if(standing != null && standing !== undefined){
        return(
            <h4>{Standings[standing]}</h4>
        );
    }
    else{
        return undefined;
    }
  }


