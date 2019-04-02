import React, { Component } from 'react'

import { Card, Avatar } from 'antd';

const { Meta } = Card;
const gridStyle = {
    width: '25%',
    textAlign: 'center',
  };

export default class PeopleCard extends Component {

    render() {
        return (
        <div>
            <Card.Grid style={gridStyle}>
                <Card
                    style={{ width: '100%' }}
                    cover={
                    <img alt="example"
                     src="https://gw.alipayobjects.com/zos/rmsportal/JiqGstEfoWAOHiTxclqi.png"
                      />}
                >
                    <Meta
                    avatar={<Avatar src={this.props.image} />}
                    title={this.props.title}
                    description={this.props.description}
                    />
                    <p>{this.props.email}</p>
                    
                </Card>
            </Card.Grid>
            {/* <Card
                title={this.props.title}
                extra={this.props.date}
            >
                {this.props.description}
            </Card> */}
        </div>
        )
    }
}