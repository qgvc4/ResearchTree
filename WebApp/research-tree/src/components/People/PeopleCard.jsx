import React, { Component } from 'react'

import { Card } from 'antd';


export default class PeopleCard extends Component {

    render() {
        return (
        <div>
            <Card
                title={this.props.title}
                extra={this.props.date}
            >
                {this.props.description}
            </Card>
        </div>
        )
    }
}